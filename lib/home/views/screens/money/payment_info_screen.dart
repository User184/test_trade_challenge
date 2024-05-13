import 'package:flutter/material.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/app/common/components/covert_data_time.dart';
import 'package:teklub/home/data/api_service_home.dart';
import 'package:teklub/home/models/api_models/payment_info_model.dart';
import 'package:teklub/home/views/widgets/home_mane_widgets/any_quastion_widget.dart';

import '../../../../app/user/models/pass_model.dart';
import '../../../../auth/models/permission_model4.dart';
import '../../../../challenge/models/promo_model.dart';
import '../../../../tests/models/test_model.dart';
import '/app/routes/route.dart' as route;
import '../../../../app/theme.dart';
import 'get_money_screen.dart';

class PaymentInfoScreen extends StatefulWidget {
  final String title;
  final String id;
  final bool cardDone;
  final PermissionModel4 model;
  final PassModel passModel;
  final PromoModel promoModel;
  final TestModel testModel;

  const PaymentInfoScreen(
      {Key key,
      this.title,
      this.id,
      this.cardDone = false,
      this.model,
      this.passModel,
      this.promoModel,
      this.testModel})
      : super(key: key);

  @override
  _PaymentInfoScreenState createState() => _PaymentInfoScreenState();
}

class _PaymentInfoScreenState extends State<PaymentInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGlobalBlack,
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
                padding: const EdgeInsets.only(top: 27),
                child: FutureBuilder<PaymentInfoModel>(
                  future: ApiServiceHome.getPaymentInfo(widget.id),
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
                      Color isSuccess = snapshot.data.data.status == 'success'
                          ? Colors.white
                          : const Color(0xff49536D);
                      return Column(
                        children: [
                          Center(
                            child: CommonTextWidget(
                              text: 'Вывод ${widget.title.toLowerCase()}',
                              size: 20,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff49536D),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          StatusWidget(
                            status: snapshot.data.data.status,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Center(
                              child: CommonTextWidget(
                                textAlign: TextAlign.center,
                                text: snapshot.data.data.comment,
                                size: 18,
                                fontWeight: FontWeight.normal,
                                color: const Color(0xff8793B4),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          if (snapshot.data.data.type == 'card')
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                  color: snapshot.data.data.status == 'success'
                                      ? kGlobal
                                      : Colors.grey[300],
                                ),
                                height: 225,
                                width: double.infinity,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: CommonTextWidget(
                                        color: isSuccess,
                                        text: snapshot.data.data.amount
                                            .replaceAll('-', '+'),
                                        size: 40,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Arial',
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 24, right: 24, bottom: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CommonTextWidget(
                                              color: isSuccess,
                                              text: '****',
                                              size: 17,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            CommonTextWidget(
                                              color: isSuccess,
                                              text: '****',
                                              size: 17,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            CommonTextWidget(
                                              color: isSuccess,
                                              text: '****',
                                              size: 17,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            CommonTextWidget(
                                              color: isSuccess,
                                              text: snapshot.data.data.card
                                                  .substring(
                                                snapshot.data.data.card.length -
                                                    4,
                                                snapshot.data.data.card.length,
                                              ),
                                              size: 17,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          if (snapshot.data.data.type == 'certificate')
                            Opacity(
                                opacity: snapshot.data.data.status == 'success'
                                    ? 1.0
                                    : 0.2,
                                child: Stack(children: [
                                  Positioned(
                                      child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      color: Colors.grey,
                                      image: DecorationImage(
                                        image: NetworkImage(snapshot
                                            .data.data.certificate['img_url']),
                                      ),
                                    ),
                                    height: 150,
                                    width: 330,
                                  )),
                                  Positioned(
                                    bottom: 15,
                                    right: 50,
                                    child: CommonTextWidget(
                                      text: snapshot
                                              .data.data.certificate['face']
                                              .toString() +
                                          "р",
                                      fontWeight: FontWeight.w700,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  )
                                ])),
                          if (snapshot.data.data.type == 'phone')
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                color: snapshot.data.data.status == 'success'
                                    ? const Color(0xff3C6FE4)
                                    : Colors.grey[300],
                              ),
                              height: 225,
                              width: 345,
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child:
                                        Image.asset('assets/images/phone.png'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 50),
                                    child: Column(
                                      children: [
                                        Center(
                                          child: CommonTextWidget(
                                            color: Colors.white,
                                            text: snapshot.data.data.amount,
                                            size: 40,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 50),
                                          child: CommonTextWidget(
                                            color: Colors.white,
                                            text: snapshot.data.data.phone,
                                            size: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        )
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(
                            height: 23,
                          ),
                          Center(
                            child: CommonTextWidget(
                              text: snapshot.data.data.createdAt != null
                                  ? convertDataTimeMoney(DateTime.parse(
                                      snapshot.data.data.createdAt.toString()))
                                  : "",
                              size: 16,
                              fontFamily: "Abel",
                              fontWeight: FontWeight.normal,
                              color: const Color(0xff8793B4),
                            ),
                          ),
                          const Spacer(),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 40),
                            child: AnyQuestionWidget(),
                          ),
                        ],
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        color: kGlobal,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                right: 10, top: MediaQuery.of(context).size.height * 0.08),
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[300]),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.close,
                        color: Color(0xff8793B4),
                      ),
                    ),
                  ),
                  onTap: () {
                    print(widget.model);
                    if (widget.cardDone) {
                      Navigator.pushReplacementNamed(context, route.homeScreen);
                    } else if (widget.model != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GetMoneyScreen(
                              model: widget.model,
                              passModel: widget.passModel,
                              promoModel: widget.promoModel,
                              testModel: widget.testModel),
                        ),
                      );
                    } else {
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatusWidget extends StatelessWidget {
  final String status;

  const StatusWidget({Key key, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        color: status == 'success'
            ? const Color(0xff13971E)
            : status == 'in_process'
                ? Colors.grey[300]
                : const Color(0xffB51919),
      ),
      width: 140,
      height: 40,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              status == 'success'
                  ? const Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    )
                  : status == 'in_process'
                      ? const Icon(
                          Icons.access_time,
                          color: Color(0xff8793B4),
                        )
                      : const Icon(
                          Icons.cancel,
                          color: Colors.white,
                        ),
              const SizedBox(
                width: 5,
              ),
              CommonTextWidget(
                text: status == 'success'
                    ? 'Успешно'
                    : status == 'in_process'
                        ? 'На проверке'
                        : 'Отказ',
                size: 14,
                color: status == 'in_process'
                    ? const Color(0xff8793B4)
                    : Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
