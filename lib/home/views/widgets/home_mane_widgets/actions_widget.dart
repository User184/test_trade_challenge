import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/app/user/models/pass_model.dart';
import 'package:teklub/auth/models/permission_model4.dart';
import 'package:teklub/challenge/models/promo_model.dart';
import 'package:teklub/home/views/screens/money/get_money_screen.dart';
import 'package:teklub/tests/models/test_model.dart';

import '/app/routes/route.dart' as route;
import '../../../../app/theme.dart';

class ActionWidget extends StatelessWidget {
  final PermissionModel4 model;
  final PassModel passModel;
  final PromoModel promoModel;
  final TestModel testMode;

  const ActionWidget(
      {Key key, this.model, this.passModel, this.promoModel, this.testMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double baseWidth = 262;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 24),
          width: double.infinity,
          height: 70 * fem,
          decoration: BoxDecoration(
            color: const Color(0xffffffff),
            borderRadius: BorderRadius.circular(12 * fem),
            boxShadow: [
              BoxShadow(
                color: const Color(0x140025c2),
                offset: Offset(0 * fem, 2 * fem),
                blurRadius: 2 * fem,
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
              AppMetrica.reportEvent(
                'balance',
              );

              Navigator.pushNamed(context, route.nachislenieScreen);
            },
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffF9F9F9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      'assets/images/icon1.svg',
                      semanticsLabel: 'icon1',
                      height: 30,
                      color: kGlobal,
                      width: 30,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                const CommonTextWidget(
                  text: 'Начисления',
                  fontWeight: FontWeight.w400,
                  size: 17,
                  color: kGlobal,
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xff8793B4),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 24),
          width: double.infinity,
          height: 70 * fem,
          decoration: BoxDecoration(
            color: const Color(0xffffffff),
            borderRadius: BorderRadius.circular(12 * fem),
            boxShadow: [
              BoxShadow(
                color: const Color(0x140025c2),
                offset: Offset(0 * fem, 2 * fem),
                blurRadius: 2 * fem,
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GetMoneyScreen(
                    model: model,
                    passModel: passModel,
                    promoModel: promoModel,
                    testModel: testMode,
                  ),
                ),
              );
            },
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffF9F9F9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      'assets/images/icon2.svg',
                      semanticsLabel: 'icon2',
                      color: kGlobal,
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CommonTextWidget(
                      text: 'Потратить баллы/\nИстория вывода',
                      fontWeight: FontWeight.w400,
                      size: 17,
                      color: kGlobal,
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(top: 3),
                    //   child: CommonTextWidget(
                    //     text: 'Выбирайте куда потратить',
                    //     size: 15,
                    //     color: Color(0xff8793B4),
                    //   ),
                    // ),
                  ],
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xff8793B4),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
