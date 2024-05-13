import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teklub/home/controllers/home_controller.dart';
import '../../../app/theme.dart';
import '/app/routes/route.dart' as route;
import '../../../app/common/components/common_text_widget.dart';
import '../../../app/routes/route.dart';
import '../../controllers/referral_controller.dart';
import '../widgets/my_invitations_widget.dart';
import '../widgets/share_view_widget.dart';

class ReferralFriendScreen extends StatelessWidget {
  const ReferralFriendScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<ReferralController>(
        init: ReferralController(),
        builder: (controller) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: kGlobalBlack,
              body: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                    top: 10,
                                  ),
                                  child: SizedBox(
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
                                            padding: EdgeInsets.only(left: 8),
                                            child: Icon(
                                              Icons.arrow_back_ios,
                                              color: Color(0xff49536D),
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        Get.put(HomeController())
                                            .currentPageChange('main');
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width / 17,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 10, left: 60),
                                  child: CommonTextWidget(
                                    text: 'Пригласи друга',
                                    fontWeight: FontWeight.w500,
                                    size: 18,
                                    color: Color(0xff49536D),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 15,
                                right: 15,
                              ),
                              child: Container(
                                height: size.height * .08,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    width: 1.5,
                                    color: kGlobal,
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          controller.changePageView(true);
                                        },
                                        child: Container(
                                          width: size.width / 2.185,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: !controller.isSelectView
                                                ? Colors.white
                                                : kGlobal,
                                          ),
                                          child: Center(
                                            child: CommonTextWidget(
                                              text: 'Пригласить друзей',
                                              fontWeight: FontWeight.w500,
                                              size: 15,
                                              color: !controller.isSelectView
                                                  ? kGlobal
                                                  : Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          controller.changePageView(false);
                                        },
                                        child: Container(
                                          width: size.width / 2.185,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: controller.isSelectView
                                                ? Colors.white
                                                : kGlobal,
                                          ),
                                          child: Center(
                                            child: CommonTextWidget(
                                              text: 'Мои приглашения',
                                              fontWeight: FontWeight.w500,
                                              size: 15,
                                              color: controller.isSelectView
                                                  ? kGlobal
                                                  : Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            controller.isSelectView
                                ? ShareViewWidget(
                                    controller: controller,
                                  )
                                : const MyInvitationsWidget()
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
