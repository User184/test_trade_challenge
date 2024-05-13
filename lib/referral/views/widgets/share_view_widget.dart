import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/common/components/common_text_widget.dart';
import '../../../app/theme.dart';
import '../../../app/user/data/api_setting_user.dart';
import '../../../app/user/models/get_profile_data_model.dart';
import '../../controllers/referral_controller.dart';
import '../../data/api_referral.dart';
import '../../models/CashbackModel.dart';
import 'copy_widget.dart';

class ShareViewWidget extends StatelessWidget {
  const ShareViewWidget({
    Key key,
    this.controller,
  }) : super(key: key);
  final ReferralController controller;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: Future.wait([
          ApiReferral.getCashback(),
          ApiSettingUser.getProfileData(),
        ]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            CashbackModel cashbackModel = snapshot.data[0];
            GetProfileDataModel profileDataModel = snapshot.data[1];
            print(profileDataModel.data);
            return Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(top: size.height * .06),
                        child: CopyWidget(
                            referralCode: profileDataModel.data != null
                                ? profileDataModel.data.referralCode
                                : "",
                            controller: controller)),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: size.height * .01, left: 38, right: 38),
                      child: Html(
                        data:
                            'Делись своим промо-кодом<br>для приглашения друзей<br>в социальных сетях<br>и мессенджерах.<br><br>Получи <b>${cashbackModel.data.referralPoints ?? 0}</b> баллов за каждого<br>зарегистрированного друга в PryanikOnline,<br>который совершит покупку акционных товаров<br> на сумму <b>${cashbackModel.data.checksSum ?? 0}</b> рублей',
                        style: {
                          "body": Style(
                            fontSize: const FontSize(16.0),
                            fontWeight: FontWeight.w500,
                            color: ThemeSettings.primaryColorText,
                            fontFamily: "SFProTextRegular",
                            lineHeight: LineHeight.number(1.1),
                          ),
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 25,
                          right: 25,
                          top: 70,
                          bottom: MediaQuery.of(context).size.height * 0.0),
                      child: Column(
                        children: [
                          Material(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            color: kGlobal,
                            child: InkWell(
                              onTap: () async {
                                controller.share(context,
                                    profileDataModel.data.referralCode);
                              },
                              child: SizedBox(
                                height: 80,
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/share.svg',
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      const CommonTextWidget(
                                        text: 'Поделиться',
                                        fontWeight: FontWeight.w700,
                                        size: 16,
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
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: kGlobal,
            ),
          );
        });
  }
}
