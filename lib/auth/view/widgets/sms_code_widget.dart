import 'dart:async';

import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get_storage/get_storage.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/app/common/components/snack_bar.dart';
import 'package:teklub/auth/controller/auth_controller.dart';
import 'package:teklub/auth/controller/reg_form_controller.dart';
import 'package:teklub/auth/models/sms_check_model.dart';

import '../../../app/user/data/api_setting_user.dart';
import '/app/routes/route.dart' as route;
import '../../../app/theme.dart';
import '../screens/reg_form.dart';

class SmsCodeWidget extends StatefulWidget {
  final Function next;
  final Function back;

  const SmsCodeWidget({Key key, this.next, this.back}) : super(key: key);

  @override
  State<SmsCodeWidget> createState() => _SmsCodeWidgetState();
}

class _SmsCodeWidgetState extends State<SmsCodeWidget> {
  Timer _timer;
  int _start = 60;

  bool activeBtn = false;

  String pastedSms;

  TextEditingController textEditingController = TextEditingController();

  void startTimer() {
    setState(() {
      activeBtn = true;
    });
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            activeBtn = false;

            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);

    return GetBuilder<AuthController>(builder: (controller) {
      return Form(
        key: controller.formKey2,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (isKeyboardVisible)
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 3),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey[300]),
                          child: const Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Icon(Icons.arrow_back_ios),
                            ),
                          ),
                        ),
                        onTap: () {
                          widget.back();
                          widget.back();
                        },
                      ),
                    ),
                  ),
                SizedBox(
                  width: isKeyboardVisible ? 40 : 30,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 10, left: isKeyboardVisible ? 0 : 60),
                  child: const CommonTextWidget(
                    text: 'Введите код из sms',
                    fontWeight: FontWeight.w500,
                    size: 20,
                    color: Color(0xff8793B4),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                controller: textEditingController,
                autocorrect: false,
                toolbarOptions: const ToolbarOptions(copy: true),
                enableInteractiveSelection: true,
                inputFormatters: [controller.maskFormatter2Sms],
                textCapitalization: TextCapitalization.sentences,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        FlutterClipboard.paste().then((value) {
                          // Do what ever you want with the value.
                          setState(() {
                            pastedSms = value;
                            textEditingController.text = pastedSms;
                            controller.saveSmsPass(pastedSms);
                          });
                          print(pastedSms);
                        });
                      },
                      icon: Icon(
                        Icons.copy,
                        color: Colors.grey[300],
                      )),
                  hintText: 'Введите sms',
                ),
                keyboardType: TextInputType.number,
                onSaved: (val) {
                  controller.saveSmsPass(val);
                },
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 5) {
                    return 'Заполните поле';
                  }
                  return null;
                },
              ),
            ),
            if (!isKeyboardVisible) const Spacer(),
            if (isKeyboardVisible)
              const SizedBox(
                height: 150,
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Отправить код повторно через XX сек.
                TextButton(
                  onPressed: activeBtn == true
                      ? null
                      : () async {
                          await controller.userLoginCheck();
                          setState(() {
                            _start = 60;
                          });
                          startTimer();
                        },
                  child: CommonTextWidget(
                    text: 'Отправить ${_start != 0 ? "код" : ""} повторно',
                    size: 16,
                    underline: _start == 0 ? true : null,
                    color: activeBtn == true ? Colors.grey[400] : kGlobal,
                  ),
                ),
                if (_start != 0)
                  CommonTextWidget(
                    text: 'через ${_start.toString()} сек',
                    size: 16,
                    color: Colors.grey[400],
                  ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 25,
                  bottom: MediaQuery.of(context).size.height * 0.05,
                  top: 5,
                  right: 25),
              child: Material(
                elevation: controller.loading != true ? 3 : 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                color: kGlobal,
                child: InkWell(
                  onTap: controller.loading == true
                      ? null
                      : () async {
                          if (controller.formKey2.currentState.validate()) {
                            controller.formKey2.currentState.save();
                            controller.toggleLoading();
                            final result = await controller.userSmsCheck();

                            if (result is SmsResponseModel) {
                              GetStorage storage = GetStorage();

                              await storage.write('domen', result.accessDomain);

                              print("domennn ${storage.read('domen')}");
                              await storage.write('token', result.accessToken);
                              print("domennn ${storage.read('token')}");
                              controller.toggleLoading();
                              AppMetrica.reportEventWithMap('registration',
                                  {'registration': 'first registration'});
                              Navigator.pushReplacementNamed(
                                  context, route.welcomeScreen);
                              ApiSettingUser.checkWelcomeScreens(false);
                            } else if (result is SmsResponseModelReg) {
                              controller.updateAuthFiles(result.files);
                              controller
                                  .updateSpecFiles(result.specializations);

                              controller.officePositions =
                                  result.officePositions;
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      KeyboardVisibilityProvider(
                                    child:
                                        RegScreen(smsResponseModelReg: result),
                                  ),
                                ),
                              );
                              controller.toggleLoading();
                            } else if (result is ErrorRequestSms) {
                              controller.toggleLoading();
                              CustomSnackBar.badSnackBar(context, result.error);
                            }
                          }
                        },
                  child: SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CommonTextWidget(
                            text: 'Далее',
                            fontWeight: FontWeight.w700,
                            size: 16,
                          ),
                          controller.loading == true
                              ? const SizedBox(
                                  width: 15,
                                  height: 15,
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                    color: kGlobal,
                                  ),
                                )
                              : const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
