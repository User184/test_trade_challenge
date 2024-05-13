import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teklub/home/views/screens/money/payment_info_screen.dart';

import '../../../../auth/models/permission_model4.dart';
import '../../../../tests/models/test_model.dart';
import '../../../data/api_service_home.dart';
import '../../../models/api_models/payment_info_model.dart';
import '/app/routes/route.dart' as route;
import '../../../../app/common/components/common_text_widget.dart';
import '../../../../app/theme.dart';
import '../../../../app/user/models/pass_model.dart';
import '../../../../challenge/models/promo_model.dart';
import '../../../controllers/nachislenie_controller.dart';
import 'act_issuing_prize.dart';

class NachislenieStatus extends StatelessWidget {
  final PromoModel promoModel;
  final PassModel passModel;
  final String withdrawalId;
  final PermissionModel4 model;
  final TestModel testModel;

  const NachislenieStatus(
      {Key key,
      this.promoModel,
      this.withdrawalId,
      this.passModel,
      this.model,
      this.testModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GetBuilder<NachislenieController>(
        init: NachislenieController(),
        builder: (controller) {
          return Scaffold(
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
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
                      padding: const EdgeInsets.only(left: 15, top: 15),
                      child: SingleChildScrollView(
                        child: FutureBuilder<PaymentInfoModel>(
                            future: ApiServiceHome.getPaymentInfo(
                                withdrawalId), //withdrawalId
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 150),
                                    child: CommonTextWidget(
                                      text: 'Ошибка, попробуйте позже',
                                      color: Colors.red,
                                      size: 18,
                                    ),
                                  ),
                                );
                              }
                              if (snapshot.hasData) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 35,
                                          height: 35,
                                          child: GestureDetector(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.grey[300]),
                                              child: const Padding(
                                                padding: EdgeInsets.all(3.0),
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 8),
                                                  child: Icon(
                                                    Icons.arrow_back_ios,
                                                    color: Color(0xff49536D),
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4.5,
                                        ),
                                        const CommonTextWidget(
                                          text: 'Вывод на карту',
                                          size: 20,
                                          color: Color(0xff49536D),
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: size.height * 0.02),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 10, right: 25),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              route.userSettingsScreen);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: colorStatus(
                                                  passModel.data.status),
                                              radius: 25,
                                              child: iconStatus(
                                                  passModel.data.status),
                                            ),
                                            const CommonTextWidget(
                                              text: 'Паспортные данные',
                                              size: 16,
                                              fontFamily: 'Arial',
                                              color: Color(0xff49536D),
                                              fontWeight: FontWeight.w400,
                                            ),
                                            const SizedBox(width: 30),
                                            const Icon(
                                              Icons.arrow_forward_ios,
                                              color: Color(0xff8793B4),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.02),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 10, right: 25),
                                      child: InkWell(
                                        onTap: passModel.data.status ==
                                                'verified'
                                            ? () {
                                                showModalBottomSheet(
                                                  barrierColor: Colors.black,
                                                  context: context,
                                                  isScrollControlled: true,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  builder: (context) {
                                                    return ActIssuingPrize(
                                                      withdrawalId:
                                                          withdrawalId,
                                                      passModel: passModel,
                                                      promoModel: promoModel,
                                                      model: model,
                                                      testModel: testModel,
                                                    );
                                                  },
                                                );
                                              }
                                            : null,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: colorStatusAct(
                                                  snapshot.data.data.actStatus),
                                              radius: 25,
                                              child: iconStatusAct(
                                                  snapshot.data.data.actStatus),
                                            ),
                                            CommonTextWidget(
                                              text: 'Получить/загрузить акт',
                                              size: 16,
                                              fontFamily: 'Arial',
                                              color: colorStatusAcRrejected(
                                                  passModel.data.status ==
                                                      'verified'),
                                              fontWeight: FontWeight.w400,
                                            ),
                                            const SizedBox(width: 30),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              color: colorStatusAcRrejected(
                                                  passModel.data.status ==
                                                      'verified'),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.06),
                                    const Divider(color: Colors.grey),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 10, right: 25),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                                const Color(0xff292C31)
                                                    .withOpacity(0.12),
                                            radius: 25,
                                            child: const Icon(
                                              Icons.info_outline,
                                              color: Color(0xff8793B4),
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          const CommonTextWidget(
                                            text:
                                                'В соответствии с Налоговым кодексом РФ, компания ТекЛюб через своего оператора ООО "Капибара" оплачивает налоги за участника акции. В связи с этим участнику необходимо предоставить паспортные данные (единоразово) и подписать акт получения приза и согласие на уплату налогов оператору акции компании ООО "Капибара" (каждый раз при получение приза).',
                                            size: 15,
                                            fontFamily: 'Arial',
                                            color: Color(0xff49536D),
                                            fontWeight: FontWeight.w400,
                                          ),
                                          const SizedBox(height: 18),
                                          Row(
                                            children: const [
                                              CircleAvatar(
                                                backgroundColor:
                                                    Color(0xffF9F9F9),
                                                radius: 20,
                                                child: CommonTextWidget(
                                                  text: '1',
                                                  size: 14,
                                                  color: Color(0xff49536D),
                                                  fontFamily: 'Arial',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              SizedBox(width: 16),
                                              Expanded(
                                                child: CommonTextWidget(
                                                  text:
                                                      'Заполните паспортные данные, дождитесь подтверждения модератором до 5х-суток',
                                                  size: 13,
                                                  maxLines: 2,
                                                  fontFamily: 'Arial',
                                                  color: Color(0xff49536D),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 12),
                                          Row(
                                            children: const [
                                              CircleAvatar(
                                                backgroundColor:
                                                    Color(0xffF9F9F9),
                                                radius: 20,
                                                child: CommonTextWidget(
                                                  text: '2',
                                                  fontFamily: 'Arial',
                                                  size: 14,
                                                  color: Color(0xff49536D),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              SizedBox(width: 16),
                                              Expanded(
                                                child: CommonTextWidget(
                                                  text:
                                                      'Нажмите "Получить/загрузить акт", получите акт на почту, указанную в профиле. Проверьте , распечатайте, подпишите и сфотографируйте акт',
                                                  size: 13,
                                                  fontFamily: 'Arial',
                                                  color: Color(0xff49536D),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 12),
                                          Row(
                                            children: const [
                                              CircleAvatar(
                                                backgroundColor:
                                                    Color(0xffF9F9F9),
                                                radius: 20,
                                                child: CommonTextWidget(
                                                  text: '3',
                                                  size: 14,
                                                  fontFamily: 'Arial',
                                                  color: Color(0xff49536D),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              SizedBox(width: 16),
                                              Expanded(
                                                child: CommonTextWidget(
                                                  text:
                                                      'Загрузите подписанный акт, нажав на "Получить/загрузить акт". Отправьте модератору на подтверждение до 5ти- суток',
                                                  size: 13,
                                                  fontFamily: 'Arial',
                                                  color: Color(0xff49536D),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 12),
                                          Row(
                                            children: const [
                                              CircleAvatar(
                                                backgroundColor:
                                                    Color(0xffF9F9F9),
                                                radius: 20,
                                                child: CommonTextWidget(
                                                  text: '4',
                                                  fontFamily: 'Arial',
                                                  size: 14,
                                                  color: Color(0xff49536D),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              SizedBox(width: 16),
                                              Expanded(
                                                child: CommonTextWidget(
                                                  text:
                                                      'Получите средства на карту.',
                                                  size: 13,
                                                  fontFamily: 'Arial',
                                                  maxLines: 2,
                                                  color: Color(0xff49536D),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.016),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 25,
                                          bottom: size.height * 0.05,
                                          top: 5,
                                          right: 25),
                                      child: Opacity(
                                        opacity: snapshot.data.data.actStatus ==
                                                'accepted'
                                            ? 1
                                            : 0.3,
                                        child: Material(
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          color: kGlobal,
                                          child: InkWell(
                                            onTap:
                                                snapshot.data.data.actStatus ==
                                                        'accepted'
                                                    ? () {
                                                        print('object');
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                PaymentInfoScreen(
                                                              title: 'на карту',
                                                              id: withdrawalId,
                                                              cardDone: true,
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                    : null,
                                            child: SizedBox(
                                              height: 80,
                                              width: double.infinity,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: const [
                                                    CommonTextWidget(
                                                      text: 'Получить приз',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      size: 16,
                                                      fontFamily: 'Arial',
                                                    ),
                                                    Padding(
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
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }

                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 200),
                                  child: CircularProgressIndicator(
                                    color: kGlobal,
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget iconStatus(String status) {
    switch (status) {
      case 'verified':
        return const Icon(
          Icons.check_circle,
          color: Colors.white,
        );
      case 'on_verification':
        return const Icon(
          Icons.watch_later_outlined,
          color: Color(0xff8793B4),
        );
      default:
        return const Icon(
          Icons.cancel,
          color: Colors.white,
        );
    }
  }

  Widget iconStatusAct(String status) {
    switch (status) {
      case 'accepted':
        return const Icon(
          Icons.check_circle,
          color: Colors.white,
        );
      case 'verification':
        return const Icon(
          Icons.watch_later_outlined,
          color: Color(0xff8793B4),
        );
      default:
        return const Icon(
          Icons.cancel,
          color: Colors.white,
        );
    }
  }

  Color colorStatus(String status) {
    switch (status) {
      case 'verified':
        return const Color(0xff13971E);
      case 'on_verification':
        return const Color(0xffF3F7FF);
      default:
        return const Color(0xffB51919);
    }
  }

  Color colorStatusAcRrejected(bool status) {
    switch (status) {
      case true:
        return const Color(0xff49536D);
      default:
        return const Color(0xff49536D).withOpacity(0.3);
    }
  }

  Color colorStatusAct(String status) {
    switch (status) {
      case "accepted":
        return const Color(0xff13971E);
      case "verification":
        return const Color(0xffF3F7FF);

      default:
        return const Color(0xffB51919);
    }
  }
}
