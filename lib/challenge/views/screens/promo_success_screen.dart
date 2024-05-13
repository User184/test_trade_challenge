import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:teklub/app/theme.dart';

import '../../../app/user/models/pass_model.dart';
import '../../../auth/models/permission_model4.dart';
import '../../../home/views/screens/money/payment_info_screen.dart';
import '../../../tests/models/test_model.dart';
import '../../models/promo_model.dart';
import '/app/routes/route.dart' as route;
import '../../../app/common/components/common_text_widget.dart';

class PromoSuccessScreen extends StatelessWidget {
  final bool mail;
  final String title;
  final String withdrawalId;
  final PermissionModel4 model;
  final PassModel passModel;
  final PromoModel promoModel;
  final TestModel testModel;

  const PromoSuccessScreen(
      {Key key,
      this.mail,
      this.title,
      this.withdrawalId,
      this.testModel,
      this.promoModel,
      this.passModel,
      this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: SizedBox(
                  width: 35,
                  height: 35,
                  child: GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey[300]),
                      child: const Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Center(
                          child: Icon(
                            Icons.close,
                            color: Color(0xff49536D),
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      if (mail == true) {
                        Navigator.of(context).pop();
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentInfoScreen(
                                title: 'на карту',
                                id: withdrawalId,
                                model: model,
                                passModel: passModel,
                                promoModel: promoModel,
                                testModel: testModel),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          SvgPicture.asset(
            'assets/images/good1.svg',
            semanticsLabel: 'Acme Logo',
            color: const Color(0xff13971E),
          ),
          const SizedBox(
            height: 20,
          ),
          const CommonTextWidget(
            text: 'Спасибо!',
            fontWeight: FontWeight.normal,
            size: 22,
            fontFamily: 'Arial',
            color: Color(0xff49536D),
          ),
          const SizedBox(
            height: 10,
          ),
          CommonTextWidget(
            text: title,
            fontWeight: FontWeight.normal,
            fontFamily: 'Arial',
            textAlign: TextAlign.center,
            size: 18,
            color: Color(0xff49536D),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(
                left: 25,
                bottom: MediaQuery.of(context).size.height * 0.05,
                top: 15,
                right: 25),
            child: Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              color: const Color(0xffF9F9F9),
              child: InkWell(
                onTap: () {
                  if (mail == true) {
                    Navigator.of(context).pop();
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentInfoScreen(
                            title: 'на карту',
                            id: withdrawalId,
                            model: model,
                            passModel: passModel,
                            promoModel: promoModel,
                            testModel: testModel),
                      ),
                    );
                  }
                },
                child: SizedBox(
                  height: 70,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonTextWidget(
                          text:
                              mail == true ? 'Назад' : 'Отправить на проверку',
                          fontWeight: FontWeight.w700,
                          size: 16,
                          color: kGlobal,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 7),
                          child: SizedBox(
                            width: 15,
                            height: 15,
                            child: Icon(
                              Icons.arrow_forward,
                              color: kGlobal,
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
        ],
      ),
    );
  }
}
