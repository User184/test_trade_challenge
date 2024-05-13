import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/app/common/components/snack_bar.dart';
import 'package:teklub/challenge/models/promo_model.dart';
import 'package:teklub/home/data/api_service_home.dart';
import 'package:teklub/home/models/api_models/send_money_phone.dart';

import '/app/routes/route.dart' as route;
import '../../../../app/user/models/pass_model.dart';
import '../../../../auth/models/permission_model4.dart';
import '../../../../challenge/views/screens/add_act_screen.dart';
import '../../widgets/home_mane_widgets/app_bar_money_widget.dart';

class AddPhoneScreen extends StatefulWidget {
  final PermissionModel4 model;
  final PassModel passModel;
  final PromoModel promoModel;
  final String rub;
  final String point;
  final String wallet;

  const AddPhoneScreen({
    Key key,
    this.rub,
    this.point,
    this.wallet,
    this.model,
    this.passModel,
    this.promoModel,
  }) : super(key: key);

  @override
  _AddPhoneScreenState createState() => _AddPhoneScreenState();
}

class _AddPhoneScreenState extends State<AddPhoneScreen> {
  // final maskFormatterCard = MaskTextInputFormatter(mask: '+7 ### ### ## ##');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool checkbox = false;

  String phone;
  String sum;

  bool loading = false;
  final maskFormatter1 = MaskTextInputFormatter(mask: '7 (###) ###-##-##');

  GetStorage storage = GetStorage();

  savePhone() {
    storage.write('phone', phone);
  }

  showAlertDialog(BuildContext context, [text]) {
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 35,
              vertical: MediaQuery.of(context).size.height * 0.22),
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset('assets/images/bad1.svg'),
                const SizedBox(
                  height: 20,
                ),
                CommonTextWidget(
                  textAlign: TextAlign.center,
                  text: text ??
                      'Не подтверждены или некорректно заполнены паспортные данные!',
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff49536D),
                  size: 16,
                ),
                const SizedBox(
                  height: 20,
                ),
                // const Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 40),
                //   child: CommonTextWidget(
                //     textAlign: TextAlign.center,
                //     text: 'Пожалуйста, проверьте остаток на балансе',
                //     fontWeight: FontWeight.normal,
                //     color: Color(0xff49536D),
                //     size: 16,
                //   ),
                // ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const CommonTextWidget(
                      text: 'Хорошо',
                      fontWeight: FontWeight.w700,
                      size: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.model.data.pointsBalance);
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      gestures: const [
        GestureType.onVerticalDragDown,
        GestureType.onVerticalDragStart,
      ],
      child: Scaffold(
        backgroundColor: const Color(0xff3C6FE4),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color(0xff3C6FE4),
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppBarMoneyWidget(
                color2: true,
                permissionModel4: widget.model,
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: TextFormField(
                            autocorrect: false,
                            inputFormatters: [maskFormatter1],
                            textCapitalization: TextCapitalization.sentences,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              hintText: 'Введите номер телефона',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelText: 'Номер телефона',
                            ),
                            keyboardType: TextInputType.number,
                            initialValue: storage.read('phone') == null
                                ? null
                                : storage.read('phone'),
                            onSaved: (val) {
                              phone = val;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Заполните поле';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: TextFormField(
                            autocorrect: false,
                            textCapitalization: TextCapitalization.sentences,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              hintText: 'Сумма вывода',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelText: 'Сумма вывода',
                            ),
                            keyboardType: TextInputType.number,
                            onSaved: (val) {
                              sum = val;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Заполните поле';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomCheckBox(
                                  value: checkbox,
                                  shouldShowBorder: true,
                                  borderColor: const Color(0xff3C6FE4),
                                  checkedFillColor: const Color(0xff3C6FE4),
                                  borderRadius: 8,
                                  borderWidth: 2,
                                  checkBoxSize: 20,
                                  onChanged: (val) {
                                    setState(() {
                                      checkbox = val;
                                    });
                                  }),
                              const Expanded(
                                child: CommonTextWidget(
                                  text: 'Сохранить номер телефона',
                                  size: 14,
                                  color: Color(0xff8793B4),
                                ),
                              )
                            ],
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 25,
                            bottom: MediaQuery.of(context).size.height * 0.05,
                            top: 5,
                            right: 25,
                          ),
                          child: Material(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            color: const Color(0xff3C6FE4),
                            child: InkWell(
                              onTap: loading == true
                                  ? null
                                  : () async {
                                      if (formKey.currentState.validate()) {
                                        formKey.currentState.save();

                                        if (checkbox == true) {
                                          savePhone();
                                        }

                                        setState(() {
                                          loading = true;
                                        });

                                        if (widget.model.data.promo.type ==
                                            'challenge') {
                                          if (widget.passModel.data.status !=
                                              'verified') {
                                            setState(() {
                                              showAlertDialog(context, true);
                                              loading = false;
                                            });
                                            return;
                                          } else {
                                            final result = await ApiServiceHome
                                                .sendPhonePayment(
                                              SendMoneyPhone(
                                                  wallet: widget.wallet,
                                                  phone: phone.replaceAll(
                                                      RegExp(r'[^0-9]'), ''),
                                                  amount: sum,
                                                  type: 'phone'),
                                            );
                                            if (result is SuccessPhone) {
                                              setState(() {
                                                loading = false;
                                              });
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddActScreen(
                                                    withdrawalId:
                                                        result.success,
                                                  ),
                                                ),
                                              );
                                            } else if (result
                                                is ErrorRequestSendMoneyPhone) {
                                              setState(() {
                                                showAlertDialog(
                                                    context, result.error);

                                                loading = false;
                                              });
                                            }

                                            setState(() {
                                              loading = false;
                                            });
                                          }
                                          loading = false;
                                        } else {
                                          final result = await ApiServiceHome
                                              .sendPhonePayment(
                                            SendMoneyPhone(
                                                wallet: widget.wallet,
                                                phone: phone.replaceAll(
                                                    RegExp(r'[^0-9]'), ''),
                                                amount: sum,
                                                type: 'phone'),
                                          );
                                          if (result is SuccessPhone) {
                                            setState(() {
                                              loading = false;
                                            });
                                            Navigator.pushReplacementNamed(
                                                context, route.homeScreen);
                                            CustomSnackBar.goodSnackBar(
                                                context, 'Запрос отправлен');
                                          } else if (result
                                              is ErrorRequestSendMoneyPhone) {
                                            setState(() {
                                              showAlertDialog(
                                                  context, result.error);

                                              loading = false;
                                            });
                                          }
                                        }
                                      }
                                    },
                              child: SizedBox(
                                height: 70,
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const CommonTextWidget(
                                        text: 'Перевести',
                                        fontWeight: FontWeight.w700,
                                        size: 16,
                                      ),
                                      loading == false
                                          ? const Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 7),
                                              child: SizedBox(
                                                width: 15,
                                                height: 15,
                                                child: Icon(
                                                  Icons.arrow_forward,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          : const SizedBox(
                                              width: 15,
                                              height: 15,
                                              child: CircularProgressIndicator(
                                                  backgroundColor:
                                                      Colors.white),
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
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
