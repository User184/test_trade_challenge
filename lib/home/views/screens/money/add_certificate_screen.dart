import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/challenge/models/promo_model.dart';
import 'package:teklub/home/data/api_service_home.dart';
import 'package:teklub/home/views/screens/money/add_sertificate_unit.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../app/user/models/pass_model.dart';
import '../../../../auth/models/permission_model4.dart';
import '../../widgets/home_mane_widgets/app_bar_money_widget.dart';

class AddSerticateScreen extends StatefulWidget {
  final PermissionModel4 model;
  final PassModel passModel;
  final PromoModel promoModel;
  final String rub;
  final String point;
  final String wallet;

  const AddSerticateScreen({
    Key key,
    this.rub,
    this.point,
    this.wallet,
    this.model,
    this.passModel,
    this.promoModel,
  }) : super(key: key);

  @override
  _AddSerticateScreenState createState() => _AddSerticateScreenState();
}

class _AddSerticateScreenState extends State<AddSerticateScreen> {
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

  bool loading = false;
  final maskFormatter1 = MaskTextInputFormatter(mask: '7 (###) ###-##-##');

  GetStorage storage = GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSertificates();
    print(widget.model.data.pointsBalance);
  }

  void getSertificates() async {
    cart = [];
    List<Widget> temp = [];
    list_sert = await ApiServiceHome.getSertificatesList();
    if (list_sert['rezult'] != null && list_sert['rezult'] == false) {
      showAlertDialog(context,
          "Что то пошло не так\n Поробуйте зайти на страницу позднее", false);
    } else {
      for (var unit in list_sert['data']) {
        temp.add(InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddSerticateUnitScreen(
                rub: widget.rub,
                point: widget.point,
                wallet: widget.wallet,
                list_sert: unit,
                model: widget.model,
                passModel: widget.passModel,
                description: unit['description'],
              ),
            ),
          ),
          child: Container(
              margin: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: Colors.grey,
                    image: DecorationImage(
                        image: NetworkImage(unit['img_url']),
                        fit: BoxFit.fitWidth)),
                height: 132,
                width: 300,
              )),
        ));
      }
    }
    setState(() {
      cart = temp;
      sert_id = 0;
    });
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
                  padding: const EdgeInsets.only(top: 20),
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
                              text: "Сертификаты",
                              fontWeight: FontWeight.w700,
                              size: 18,
                              textAlign: TextAlign.left,
                              color: Color(0xff49536D),
                            )),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                color: Colors.white,
                                width: MediaQuery.of(context).size.width / 0.2,
                                height: sert_id != 0
                                    ? MediaQuery.of(context).size.height / 1.8
                                    : MediaQuery.of(context).size.height / 1.4,
                                child: ListView(
                                  children: cart,
                                ))),
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 25,
                              right: 25,
                              bottom: MediaQuery.of(context).size.height * 0.01,
                              top: 5),
                          child: Material(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            color: Color(0xff3C6FE4),
                            // child: InkWell(
                            //   onTap: () => setBuy(),
                            //   child: sert_id != 0
                            //       ? SizedBox(
                            //           height: 70,
                            //           width: double.infinity,
                            //           child: Padding(
                            //             padding: const EdgeInsets.symmetric(
                            //                 horizontal: 15),
                            //             child: Row(
                            //               crossAxisAlignment:
                            //                   CrossAxisAlignment.center,
                            //               mainAxisAlignment:
                            //                   MainAxisAlignment.spaceBetween,
                            //               children: [
                            //                 const CommonTextWidget(
                            //                   text: 'Получить',
                            //                   fontWeight: FontWeight.w700,
                            //                   size: 16,
                            //                 ),
                            //                 loading == false
                            //                     ? const Padding(
                            //                         padding: EdgeInsets.only(
                            //                             bottom: 7),
                            //                         child: SizedBox(
                            //                           width: 15,
                            //                           height: 15,
                            //                           child: Icon(
                            //                             Icons.arrow_forward,
                            //                             color: Colors.white,
                            //                           ),
                            //                         ),
                            //                       )
                            //                     : const SizedBox(
                            //                         width: 15,
                            //                         height: 15,
                            //                         child:
                            //                             CircularProgressIndicator(
                            //                                 backgroundColor:
                            //                                     Colors.white),
                            //                       ),
                            //               ],
                            //             ),
                            //           ),
                            //         )
                            //       : Container(),
                            // ),
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
