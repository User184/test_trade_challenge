import 'dart:async';

import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/app/user/data/api_setting_user.dart';
import 'package:teklub/app/user/models/get_profile_data_model.dart';
import 'package:teklub/app/user/models/pass_model.dart';
import 'package:teklub/auth/controller/reg_form_controller.dart';
import 'package:teklub/auth/models/permission_model4.dart';
import 'package:teklub/challenge/models/promo_model.dart';
import 'package:teklub/home/data/api_service_home.dart';
import 'package:teklub/home/models/api_models/send_money_card_model.dart';
import 'package:teklub/home/models/widgets_models/credit_card_model.dart';
import '../../../../tests/models/test_model.dart';
import '/app/routes/route.dart' as route;
import '../../../../app/theme.dart';
import '../../widgets/home_mane_widgets/app_bar_money_widget.dart';
import 'get_money_screen.dart';
import 'nachislenie_status.dart';

class CardScreen extends StatefulWidget {
  final PermissionModel4 model;
  final PassModel passModel;
  final PromoModel promoModel;
  final TestModel testModel;
  final String rub;
  final String point;
  final String wallet;
  final Function updt;

  const CardScreen({
    Key key,
    this.rub,
    this.point,
    this.wallet,
    this.model,
    this.passModel,
    this.promoModel,
    this.updt,
    this.testModel,
  }) : super(key: key);

  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  final maskFormatterCard = MaskTextInputFormatter(mask: '#### #### #### ####');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool checkbox = false;

  String sum;
  String cardNum;
  String cardHolder;
  String fio;

  bool loading = false;

  CreditCard creditCard;

  setCreditCard() {
    if (storage.read('creditCard') != null) {
      creditCard = CreditCard.fromJson(
        storage.read('creditCard'),
      );
    }
  }

  GetStorage storage = GetStorage();

  saveCard() {
    Map res = CreditCard(
      cardNum: cardNum,
      cardHolder: cardHolder,
      fio: fio,
    ).toJson();
    storage.write('creditCard', res);
  }

  showAlertDialog(BuildContext context,
      {String text, GetProfileDataModel data}) {
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
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 40),
                //   child: CommonTextWidget(
                //     textAlign: TextAlign.center,
                //     text: text ?? 'Пожалуйста, проверьте остаток на балансе',
                //     fontWeight: FontWeight.normal,
                //     color: const Color(0xff49536D),
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
                      if (text == null) {
                        Get.delete<RegFormController>(force: true);
                        Navigator.pushReplacementNamed(
                            context, route.userSettingsScreen);
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(kGlobal)),
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
    setCreditCard();
    // print(widget.model.data.);
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      gestures: const [
        GestureType.onVerticalDragDown,
        GestureType.onVerticalDragStart,
      ],
      child: Scaffold(
        backgroundColor: kGlobalBlack,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: kGlobalBlack,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GetMoneyScreen(
                        model: widget.model,
                        passModel: widget.passModel,
                        promoModel: widget.promoModel,
                        testModel: widget.testModel),
                  ));
            },
          ),
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppBarMoneyWidget(
                permissionModel4: widget.model,
                color2: true,
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
                    child: FutureBuilder(
                        future: Future.wait([
                          ApiSettingUser.getProfileData(),
                          ApiSettingUser.getPassportData()
                        ]),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            PassModel pass = snapshot.data[1];
                            GetProfileDataModel profileDataModel =
                                snapshot.data[0];
                            print(pass.data.status);
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 10),
                                    child: TextFormField(
                                      autocorrect: false,
                                      inputFormatters: [maskFormatterCard],
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      textInputAction: TextInputAction.next,
                                      decoration: const InputDecoration(
                                        hintText: 'Введите номер карты',
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        labelText: 'Номер карты',
                                      ),
                                      keyboardType: TextInputType.number,
                                      initialValue: creditCard == null
                                          ? null
                                          : creditCard.cardNum,
                                      onSaved: (val) {
                                        cardNum = val;
                                      },
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            value.length < 19) {
                                          return 'Заполните поле';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: TextFormField(
                                      autocorrect: false,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      textInputAction: TextInputAction.next,
                                      decoration: const InputDecoration(
                                        hintText: 'IVANOV IVAN',
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        labelText: 'Имя владельца',
                                      ),
                                      keyboardType: TextInputType.text,
                                      initialValue: creditCard == null
                                          ? null
                                          : creditCard.cardHolder,
                                      onSaved: (val) {
                                        cardHolder = val;
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
                                    height: 25,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: TextFormField(
                                      autocorrect: false,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      textInputAction: TextInputAction.next,
                                      decoration: const InputDecoration(
                                        hintText: 'Иванов Иван Иванович',
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        labelText: 'ФИО',
                                      ),
                                      keyboardType: TextInputType.text,
                                      initialValue: creditCard == null
                                          ? null
                                          : creditCard.fio,
                                      onSaved: (val) {
                                        fio = val;
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CustomCheckBox(
                                            value: checkbox,
                                            shouldShowBorder: true,
                                            borderColor: const Color(0xff3C6FE4)
                                                .withOpacity(0.3),
                                            checkedFillColor: kGlobal,
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
                                            text: 'Сохранить данные о карте',
                                            size: 14,
                                            color: Color(0xff8793B4),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: TextFormField(
                                      autocorrect: false,
                                      enabled: false,
                                      initialValue: widget
                                          .model.data.pointsBalance
                                          .toString(),
                                      textCapitalization:
                                          TextCapitalization.sentences,
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
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.12,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 25,
                                        bottom:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        top: 5,
                                        right: 25),
                                    child: Material(
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      color: kGlobal,
                                      child: InkWell(
                                        onTap: loading == true
                                            ? null
                                            : () async {
                                                if (formKey.currentState
                                                    .validate()) {
                                                  formKey.currentState.save();

                                                  setState(() {
                                                    loading = true;
                                                  });
                                                  if (checkbox == true) {
                                                    saveCard();
                                                  }
                                                  int sumFix;
                                                  try {
                                                    sumFix = int.parse(sum);
                                                  } catch (e) {
                                                    sumFix = 0;
                                                  }
                                                  if (pass.data.status !=
                                                      'verified') {
                                                    setState(() {
                                                      showAlertDialog(context,
                                                          data:
                                                              profileDataModel);
                                                      loading = false;
                                                    });
                                                    return;
                                                  } else {
                                                    final result =
                                                        await ApiServiceHome
                                                            .sendCardPayment(
                                                      SendMoneyCard(
                                                        wallet: widget.wallet,
                                                        card: cardNum
                                                                .replaceAll(
                                                                    " ", "")
                                                                .replaceAll(
                                                                    "-", "") ??
                                                            creditCard.cardNum,
                                                        fio: fio ??
                                                            creditCard.fio,
                                                        cardHolderName:
                                                            cardHolder ??
                                                                creditCard
                                                                    .cardHolder,
                                                        amount: sum,
                                                        type: 'card',
                                                      ),
                                                    );

                                                    if (result is SuccessCard) {
                                                      setState(() {
                                                        widget.model.data
                                                                .pointsBalance -=
                                                            int.parse(sum,
                                                                onError: (e) =>
                                                                    0);
                                                        loading = false;
                                                      });
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              NachislenieStatus(
                                                            promoModel: widget
                                                                .promoModel,
                                                            withdrawalId:
                                                                result.success,
                                                            passModel: widget
                                                                .passModel,
                                                            testModel: widget
                                                                .testModel,
                                                            model: widget.model,
                                                          ),
                                                        ),
                                                      );
                                                    } else if (result
                                                        is ErrorRequestSendMoneyCard) {
                                                      setState(() {
                                                        showAlertDialog(context,
                                                            text: result.error);

                                                        loading = false;
                                                      });
                                                    }
                                                  }
                                                  loading = false;

                                                  // if (widget.model.data.promo.type ==
                                                  //     'challenge') {
                                                  //
                                                  // }

                                                  // else {
                                                  //   final result = await ApiServiceHome
                                                  //       .sendCardPayment(
                                                  //     SendMoneyCard(
                                                  //       wallet: widget.wallet,
                                                  //       card: cardNum
                                                  //               .replaceAll(" ", "")
                                                  //               .replaceAll("-", "") ??
                                                  //           creditCard.cardNum,
                                                  //       fio: fio ?? creditCard.fio,
                                                  //       cardHolderName: cardHolder ??
                                                  //           creditCard.cardHolder,
                                                  //       amount: sum,
                                                  //       type: 'card',
                                                  //     ),
                                                  //   );
                                                  //
                                                  //   if (result is SuccessCard) {
                                                  //     setState(() {
                                                  //       loading = false;
                                                  //     });
                                                  //     Navigator.pushReplacementNamed(
                                                  //         context, route.homeScreen);
                                                  //     CustomSnackBar.goodSnackBar(
                                                  //         context, 'Запрос отправлен');
                                                  //   }
                                                  //
                                                  //   if (result
                                                  //       is ErrorRequestSendMoneyCard) {
                                                  //     print('!!!!');
                                                  //     setState(
                                                  //       () {
                                                  //         showAlertDialog(
                                                  //             context, result.error);
                                                  //
                                                  //         loading = false;
                                                  //       },
                                                  //     );
                                                  //   }
                                                  // }
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const CommonTextWidget(
                                                  text: 'Перевести',
                                                  fontWeight: FontWeight.w700,
                                                  size: 16,
                                                ),
                                                loading == false
                                                    ? const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 7),
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
                                                        child:
                                                            CircularProgressIndicator(
                                                                color: kGlobal,
                                                                backgroundColor:
                                                                    Colors
                                                                        .white),
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
                          }
                          return const Center(
                            child: CircularProgressIndicator(
                                color: kGlobal, backgroundColor: Colors.white),
                          );
                        }),
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
