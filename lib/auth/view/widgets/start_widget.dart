import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/app/common/components/snack_bar.dart';
import 'package:teklub/app/common/components/url_laoucher.dart';
import 'package:teklub/auth/controller/auth_controller.dart';
import 'package:teklub/auth/models/login_check_models.dart';
import 'package:teklub/auth/view/screens/reg_form.dart';

import '/app/routes/route.dart' as route;
import '../../../app/theme.dart';
import '../../models/promo_check_model.dart';

class StartWidget extends StatelessWidget {
  final Function next;

  const StartWidget({Key key, this.next}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);

    return GetBuilder<AuthController>(
      init: AuthController(),
      autoRemove: false,
      builder: (controller) {
        return Form(
          key: controller.formKey11,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RegScreen()));
                  },
                  child: const CommonTextWidget(
                    text: 'Название компании',
                    fontWeight: FontWeight.w500,
                    size: 20,
                    color: Color(0xff8793B4),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                  autocorrect: false,
                  enabled: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      hintText: 'TekLub',
                      hintStyle:
                          TextStyle(fontSize: 16, color: Color(0xff131313))),
                  keyboardType: TextInputType.text,
                  onSaved: (val) {
                    // controller.saveLoginCheckFormCompanyName(val.toLowerCase());
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: CommonTextWidget(
                  text: 'Введите номер телефона',
                  fontWeight: FontWeight.w500,
                  color: Color(0xff8793B4),
                  size: 20,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                  inputFormatters: [controller.maskFormatter1],
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    hintText: '+7 (___) ___-__-__',
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (val) {
                    controller.saveLoginCheckFormPhoneNumber(val);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Заполните поле';
                    }
                    return null;
                  },
                ),
              ),
              if (!isKeyboardVisible) const Spacer(),
              TextButton(
                onPressed: () {
                  UrlLauncher.launchEmail();
                },
                child: const CommonTextWidget(
                  text: 'Написать в поддержку',
                  size: 16,
                  color: kGlobal,
                ),
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
                            if (controller.formKey11.currentState.validate()) {
                              controller.formKey11.currentState.save();
                              controller.toggleLoading();
                              final result = await controller.userLoginCheck();
                              if (result is LoginResponseModel) {
                                print('object');
                                if (result.code == 254) {
                                  next(true);
                                } else if (result.code == 251) {
                                  print('11111');
                                  final result =
                                      await controller.userPromoCheck();
                                  print('11111${result}');
                                  if (result is PromoResponseModel) {
                                    print('11111${result.code}');
                                    if (result.code == 254) {
                                      next(true);
                                    } else {
                                      controller.toggleLoading();
                                      CustomSnackBar.badSnackBar(
                                          context, 'Код не найден2.');
                                    }
                                  }
                                }
                                controller.toggleLoading();
                              } else if (result is ErrorRequestLogin) {
                                controller.toggleLoading();
                                CustomSnackBar.badSnackBar(
                                    context, result.error);
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
      },
    );
  }
}
