import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/common/components/common_text_widget.dart';
import '../../../app/common/components/covert_data_time.dart';
import '../../../app/theme.dart';
import '../../data/api_referral.dart';
import '../../models/my_referral_model.dart';

class MyInvitationsWidget extends StatelessWidget {
  const MyInvitationsWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return FutureBuilder<AbsMyReferralModel>(
        future: ApiReferral.getMyReferral(),
        builder: (context, snapshot) {
          print(snapshot.hasData);
          if (snapshot.hasData) {
            print('object');
            MyReferralModel myReferralModel = snapshot.data as MyReferralModel;
            return Column(
              children: [
                Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: DataTable(
                    columnSpacing: size.width * 0.07,
                    columns: [
                      DataColumn(
                        label: SizedBox(
                          width: size.width * .2,
                          child: CommonTextWidget(
                            text: 'Фамилия \nИмя',
                            color: ThemeSettings.primaryColorText,
                            fontWeight: FontWeight.w600,
                            size: 10,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: CommonTextWidget(
                          text: 'Дата \nрегистрации',
                          fontWeight: FontWeight.w600,
                          color: ThemeSettings.primaryColorText,
                          size: 10,
                        ),
                      ),
                      DataColumn(
                        label: CommonTextWidget(
                          text: 'Сумма \nчеков',
                          color: ThemeSettings.primaryColorText,
                          fontWeight: FontWeight.w600,
                          size: 10,
                        ),
                      ),
                      DataColumn(
                        label: CommonTextWidget(
                          text: 'Бонус\n за друга',
                          color: ThemeSettings.primaryColorText,
                          fontWeight: FontWeight.w600,
                          size: 10,
                        ),
                      ),
                    ],
                    rows: myReferralModel.data
                        .map(
                          (result) => DataRow(
                            cells: [
                              DataCell(
                                CommonTextWidget(
                                  text: result.fio,
                                  color: const Color(0xff8793B4),
                                  fontWeight: FontWeight.w700,
                                  size: 12,
                                ),
                              ),
                              DataCell(
                                CommonTextWidget(
                                  text: convertDataTime(
                                      DateTime.parse(result.createdAt)),
                                  color: const Color(0xff8793B4),
                                  fontWeight: FontWeight.w700,
                                  size: 12,
                                ),
                              ),
                              DataCell(
                                CommonTextWidget(
                                  text:
                                      '${result.sum != null ? fixStringSum(result.sum) : 0}',
                                  color: const Color(0xff8793B4),
                                  fontWeight: FontWeight.w700,
                                  size: 12,
                                ),
                              ),
                              DataCell(
                                Container(
                                  height: 25,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: result.referralBonus
                                          ? const Color(0xff1FCED7)
                                          : const Color.fromRGBO(
                                              41, 44, 49, 0.12)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, top: 6, bottom: 6),
                                    child: CommonTextWidget(
                                      maxLines: 1,
                                      text: result.referralBonus
                                          ? "Успешно"
                                          : 'В ожидании',
                                      color: result.referralBonus
                                          ? Colors.white
                                          : const Color(0xff8793B4),
                                      fontWeight: FontWeight.w700,
                                      size: 11,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                if (myReferralModel.data.isEmpty)
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/images/face_sad.svg',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CommonTextWidget(
                          text:
                              'К сожалению никто из друзей не зарегистрировался.',
                          color: ThemeSettings.primaryColorText,
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.center,
                          size: 18,
                        ),
                      ],
                    ),
                  )
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  String fixStringSum(String text) {
    if (int.parse(text) > 100) {
      return (int.parse(text) / 100).toStringAsFixed(0);
    } else {
      return (int.parse(text) / 100).toString();
    }
  }
}
