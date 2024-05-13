import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sizer/sizer.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/app/common/components/snack_bar.dart';
import 'package:teklub/app/user/screens/user_settings_screen.dart';
import 'package:teklub/challenge/models/promo_model.dart';
import 'package:teklub/home/data/api_service_home.dart';
import 'package:teklub/home/views/widgets/add_sertificates/selectmaster.dart';

import '/app/routes/route.dart' as route;
import '../../../../app/user/models/pass_model.dart';
import '../../../../auth/models/permission_model4.dart';
import '../../../../challenge/views/screens/add_act_screen.dart';
import '../../widgets/home_mane_widgets/app_bar_money_widget.dart';

class AddSerticateUnitScreen extends StatefulWidget {
  final PermissionModel4 model;
  final PassModel passModel;
  final PromoModel promoModel;
  final String rub;
  final String point;
  final String wallet;
  final String description;

  final Map list_sert;

  const AddSerticateUnitScreen({
    Key key,
    this.rub,
    this.point,
    this.wallet,
    this.list_sert,
    this.model,
    this.description,
    this.passModel,
    this.promoModel,
  }) : super(key: key);

  @override
  _AddSerticateUnitScreenState createState() => _AddSerticateUnitScreenState();
}

class _AddSerticateUnitScreenState extends State<AddSerticateUnitScreen> {
  // final maskFormatterCard = MaskTextInputFormatter(mask: '+7 ### ### ## ##');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String sale_cert = "";
  int sale_cert_int = 0;
  int sert_id = 0;
  var list_sert = null;
  bool checkbox = false;
  List<Widget> cart = [];
  String phone;
  String sum;
  String sert_if = "0";
  List ar_sale = [];
  bool loading = false;
  final maskFormatter1 = MaskTextInputFormatter(mask: '7 (###) ###-##-##');

  GetStorage storage = GetStorage();

  @override
  void initState() {
    print(
        "widget.list_sert 111 ${widget.rub} ${widget.point} ${widget.wallet}");

    sert_id = widget.list_sert['id'];

    // TODO: implement initState
    super.initState();
    Timer(Duration(milliseconds: 500), () => setSertificate());
    createSale();
  }

  void createSale() {
    int i = 0;
    for (var unit in widget.list_sert['faces']) {
      Map temp = {"id": i.toString(), "name": unit.toString()};
      ar_sale.add(temp);
      i++;
    }
  }

  void setBuy(BuildContext context, String text_mes, bool th) async {
    if (sale_cert_int == 0) {
      showAlertDialog(context, "Выберите номинал", true);
    } else {
      if (widget.model.data.promo.type == 'challenge') {
        if (widget.passModel.data.status != 'verified') {
          setState(() {
            showAlertDialog(context, text_mes, th);

            loading = false;
          });
          return;
        } else {
          var rezult = await ApiServiceHome.setSertificatesBuy(
              sert_id.toString(), sale_cert_int.toString(), widget.wallet);

          print('!!!!!$rezult');

          if (rezult[0] == 465) {
          } else if (rezult[0] == 462) {
            showAlertDialog(context, "Недостаточно средств!", true);
          } else if (rezult[0] == 466) {
            CustomSnackBar.badSnackBar(
                context, 'Заявка на выплату уже существует');
          } else if (rezult[0] == 201) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddActScreen(
                  withdrawalId: rezult[1],
                ),
              ),
            );
          } else {
            showAlertDialog(context, "Недостаточно средств!", true);
          }

          loading = false;
        }
      } else {
        var rezult = await ApiServiceHome.setSertificatesBuy(
            sert_id.toString(), sale_cert_int.toString(), widget.wallet);
        print('!!!!!$rezult');
        if (rezult[0] == 465) {
        } else if (rezult[0] == 462) {
          showAlertDialog(context, "Недостаточно средств!", true);
        } else if (rezult[0] == 201) {
          Navigator.pushNamedAndRemoveUntil(
              context, route.homeScreen, (r) => false);
          CustomSnackBar.goodSnackBar(context, 'Сертификат оформлен');
        } else {
          showAlertDialog(context, "Недостаточно средств!", true);
        }
      }
    }
  }

  void setSertificate() {
    if (widget.list_sert != null) {
      List<Widget> temp = [];
      if (widget.list_sert['rezult'] == null ||
          widget.list_sert['rezult'] == false) {
        sale_cert = sale_cert.length == 0 ? "" : sale_cert + " р";
        List<dynamic> list_nom = widget.list_sert['faces'];
        temp = [
          Stack(
            children: [
              Positioned(
                  child: Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          image: DecorationImage(
                              image: NetworkImage(widget.list_sert['img_url']),
                              fit: BoxFit.fitWidth)),
                      height: 132,
                      width: 300,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: CommonTextWidget(
                        text: widget.description,
                        size: 16,
                        color: const Color(0xff49536D),
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: CommonTextWidget(
                        text: 'Выберите номинал сертификата',
                        size: 16,
                        color: Color(0xff49536D),
                      ),
                    ),
                  ],
                ),
              )),
              Positioned(
                bottom: 20,
                right: 50,
                child: CommonTextWidget(
                  text: sale_cert,
                  fontWeight: FontWeight.w700,
                  size: 18,
                  color: Colors.white,
                ),
              )
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.elliptical(20, 20),
              ),
              border: Border.all(color: const Color(0xff3C6FE4)),
            ),
            child: ListProfile(ar_sale, setSale, sert_if),
          )
        ];
        //   }
        // }
        setState(() {
          cart = temp;
        });
      }
    }
  }

  void setSale(String value) {
    print("rexzult ${value}");
    for (var unit in ar_sale) {
      if (unit['id'] == value) {
        sale_cert = unit['name'];
        sale_cert_int = int.parse(unit['name']);
        sert_if = unit['id'];
      }
    }
    setSertificate();
  }

  showAlertDialog(BuildContext context, String text_mes, bool th) {
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
                  text: text_mes,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff49536D),
                  size: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: CommonTextWidget(
                    textAlign: TextAlign.center,
                    text: 'Пожалуйста, проверьте остаток на балансе',
                    fontWeight: FontWeight.normal,
                    color: Color(0xff49536D),
                    size: 16,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ElevatedButton(
                    onPressed: () {
                      th == true
                          ? Navigator.pop(context)
                          : Navigator.pushNamed(context, "getMoneyScreen");
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
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      gestures: const [
        GestureType.onVerticalDragDown,
        GestureType.onVerticalDragStart,
      ],
      child: Scaffold(
        backgroundColor: const Color(0xff3C6FE4),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color(0xff3C6FE4),
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
            Container(
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
                  padding: EdgeInsets.only(top: 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(
                              top: 0,
                              left: MediaQuery.of(context).size.width / 10,
                            ),
                            padding: const EdgeInsets.only(left: 0, bottom: 10),
                            child: const CommonTextWidget(
                              text: "Сертификат",
                              fontWeight: FontWeight.w700,
                              size: 18,
                              textAlign: TextAlign.left,
                              color: Color(0xff49536D),
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width / 0.2,
                            height: sert_id != 0
                                ? MediaQuery.of(context).size.height / 1.8
                                : MediaQuery.of(context).size.height / 1.4,
                            child: ListView(
                              children: cart,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25, bottom: 20, top: 5, right: 25),
                          child: Material(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            color: const Color(0xff3C6FE4),
                            child: InkWell(
                              onTap: () {
                                if (widget.model.data.email == null) {
                                  showModalBottomSheet(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    context: context,
                                    builder: (context) => Container(
                                      height: 40.h,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          topLeft: Radius.circular(20),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(top: 20),
                                            child: CommonTextWidget(
                                              text: 'Заполните почту',
                                              size: 20,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xff49536D),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 30,
                                                right: 30,
                                                top: 20,
                                                bottom: 20),
                                            child: CommonTextWidget(
                                              text:
                                                  'Для получения сертификата/приза необходимо заполнить поле email',
                                              size: 18,
                                              fontWeight: FontWeight.normal,
                                              color: Color(0xff49536D),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          const Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 25, bottom: 20, top: 25),
                                            child: Material(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(16.0),
                                                  bottomLeft:
                                                      Radius.circular(16.0),
                                                ),
                                              ),
                                              color: const Color(0xff3C6FE4),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const UserSettingsScreen(),
                                                    ),
                                                  );
                                                },
                                                child: SizedBox(
                                                  height: 70,
                                                  width: double.infinity,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 15),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: const [
                                                        CommonTextWidget(
                                                          text:
                                                              'Заполнить данные',
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          size: 16,
                                                        ),
                                                        Icon(
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
                                    ),
                                  );
                                } else {
                                  setBuy(
                                      context, "Недостаточно средств!", true);
                                }
                              },
                              child: sert_id != 0
                                  ? SizedBox(
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
                                              text: 'Получить',
                                              fontWeight: FontWeight.w700,
                                              size: 16,
                                            ),
                                            loading == false
                                                ? const Padding(
                                                    padding: EdgeInsets.only(
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
                                                            backgroundColor:
                                                                Colors.white),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(),
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

class AppBarMoneyWidget2 extends StatelessWidget {
  final String rub;
  final String point;

  const AppBarMoneyWidget2({
    Key key,
    this.rub,
    this.point,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CommonTextWidget(
          text: " / " + point + " б",
          fontWeight: FontWeight.w700,
          size: 20,
          color: Colors.white.withOpacity(0.5),
        ),
      ],
    );
  }
}
