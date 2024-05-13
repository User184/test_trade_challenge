import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/app/user/models/pass_model.dart';
import 'package:teklub/auth/models/permission_model4.dart';
import 'package:teklub/challenge/models/promo_model.dart';
import 'package:teklub/home/controllers/home_controller.dart';
import 'package:teklub/home/data/api_service_home.dart';
import 'package:teklub/home/models/api_models/get_money_history_model.dart';
import 'package:teklub/home/models/widgets_models/credit_card_model.dart';
import 'package:teklub/home/views/widgets/get_money_widgets/history_widget.dart';
import 'package:teklub/home/views/widgets/get_money_widgets/where_send_money_widget.dart';
import 'package:teklub/home/views/widgets/home_mane_widgets/app_bar_money_widget.dart';

import '../../../../app/routes/route.dart';
import '../../../../app/theme.dart';
import '../../../../tests/models/test_model.dart';
import '../../../notofiaction/views/screens/msg_screen.dart';
import 'add_card_screen.dart';

class GetMoneyScreen extends StatefulWidget {
  final PermissionModel4 model;
  final PassModel passModel;
  final PromoModel promoModel;
  final TestModel testModel;

  const GetMoneyScreen(
      {Key key, this.model, this.passModel, this.promoModel, this.testModel})
      : super(key: key);

  @override
  State<GetMoneyScreen> createState() => _GetMoneyScreenState();
}

class _GetMoneyScreenState extends State<GetMoneyScreen> {
  final GetStorage storage = GetStorage();

  CreditCard creditCard;

  setCreditCard() {
    if (storage.read('creditCard') != null) {
      creditCard = CreditCard.fromJson(
        storage.read('creditCard'),
      );
    }
  }

  updateScreen() {
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCreditCard();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: kGlobalBlack,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: kGlobalBlack,
            leading: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, homeScreen);
                },
                icon: const Icon(Icons.arrow_back_ios)),
            title: Row(
              children: [
                const Spacer(),
                AppBarMoneyWidget(
                  color: 0xffffffff,
                  permissionModel4: widget.model ?? PermissionModel4(),
                )
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MsgScreen()),
                  );
                },
                icon: const Icon(
                  CupertinoIcons.bell,
                  color: Colors.white,
                ),
              )
            ],
          ),
          body: SlidingUpPanel(
            controller: controller.panelController,
            parallaxEnabled: true,
            parallaxOffset: .5,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            maxHeight: MediaQuery.of(context).size.height * 0.9,
            minHeight: MediaQuery.of(context).size.height * 0.45,
            panel: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 10),
                    child: Center(
                      child: Container(
                        width: 50,
                        height: 8,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(40),
                          ),
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 10),
                    child: CommonTextWidget(
                      text: 'История',
                      size: 18,
                      fontFamily: 'Arial',
                      color: Color(0xff49536D),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  FutureBuilder<GetMoneyHistory>(
                      future: ApiServiceHome.getMoneyHistory(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: CommonTextWidget(
                              text: 'Ошибка, попробуйте позже',
                              color: Colors.red,
                              size: 18,
                            ),
                          );
                        }
                        if (snapshot.hasData) {
                          if (snapshot.data.data == null ||
                              snapshot.data.data.isEmpty) {
                            return const Center(
                              child: CommonTextWidget(
                                text: 'Выплат нет',
                                color: Color(0xff49536D),
                                size: 18,
                              ),
                            );
                          } else {
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 30),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: snapshot.data.data
                                        .map(
                                          (e) => HistoryWidget(
                                            status: e.status,
                                            title: e.title,
                                            date: e.createdAt,
                                            sum: e.amount,
                                            id: e.id.toString(),
                                            type: widget.model.data.promo.type,
                                            hasActs: e.hasActs,
                                            updt: updateScreen,
                                            model: widget.model,
                                            passModel: widget.passModel,
                                            promoModel: widget.promoModel,
                                            testModel: widget.testModel,
                                            actStatus: e.actStatus,
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ),
                            );
                          }
                        }
                        return const Center(
                          child: CircularProgressIndicator(
                            color: kGlobal,
                          ),
                        );
                      }),
                ],
              ),
            ),
            body: Column(
              children: [
                WhereSendMoneyWidget(
                  passModel: widget.passModel,
                  model: widget.model,
                  promoModel: widget.promoModel,
                  icon: Icons.payment_outlined,
                  color: kGlobal,
                  title: 'Вывод на карту',
                  // subString: creditCard?.cardNum ?? 'Добавьте карту',

                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CardScreen(
                          passModel: widget.passModel,
                          model: widget.model,
                          point: widget.model.data.pointsBalance.toString(),
                          wallet: 'points',
                          promoModel: widget.promoModel,
                          testModel: widget.testModel,
                        ),
                      ),
                    );
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => NachislenieStatus(),
                    //   ),
                    // );
                  },
                ),
                // WhereSendMoneyWidget(
                //     promoModel: widget.promoModel,
                //     passModel: widget.passModel,
                //     model: widget.model,
                //     icon: Icons.phone_in_talk,
                //     color: const Color(0xffFF6E7A),
                //     title: 'На телефон',
                //     // subString:
                //     //     storage.read('phone') ?? 'Добавьте номер телефона',
                //     onTap: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => AddPhoneScreen(
                //             passModel: widget.passModel,
                //             model: widget.model,
                //             point: widget.model.data.pointsBalance.toString(),
                //             wallet: 'points',
                //             promoModel: widget.promoModel,
                //           ),
                //         ),
                //       );
                //     }),
                // WhereSendMoneyWidget(
                //   promoModel: widget.promoModel,
                //   passModel: widget.passModel,
                //   model: widget.model,
                //   icon: Icons.payment,
                //   color: const Color(0xff3C6FE4),
                //   title: 'Сертификаты',
                //   // subString: '',
                //   onTap: (){
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => AddSerticateScreen(
                //           passModel: widget.passModel,
                //           model: widget.model,
                //           point: widget.model.data.pointsBalance.toString(),
                //           wallet: 'points',
                //           promoModel: widget.promoModel,
                //         ),
                //       ),
                //     );
                //   },
                // ),
                // WhereSendMoneyWidget(
                //   promoModel: widget.promoModel,
                //   passModel: widget.passModel,
                //   model: widget.model,
                //   icon: Icons.card_giftcard,
                //   color: const Color(0xff1FCED7),
                //   title: 'Каталог подарков',
                //   subString: '',
                //   onTap: (){
                //
                //     Get.put(HomeController()).currentPageChange('gift_catalog');
                //     Navigator.pop(context);
                //     // Navigator.push(
                //     //   context,
                //     //     MaterialPageRoute(
                //     //         builder: (context) => GiftCatalogScreen(
                //     //           model: widget.model,
                //     //           promoModel: widget.promoModel,
                //     //           passModel: widget.passModel,
                //     //           testModel:widget.testModel
                //     //         )
                //     //     ),
                //     // );
                //
                //   },
                // ),

                // WhereSendMoneyWidget(
                //   icon: Icons.card_giftcard,
                //   color: Color(0xff3C6FE4),
                //   title: 'Сертификат',
                //   subString: '124 сертификата',
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
