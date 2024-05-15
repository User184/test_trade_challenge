import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:teklub/app/common/components/snack_bar.dart';

import '../../../../app/common/components/common_text_widget.dart';
import '../../../../app/theme.dart';
import '../../../../app/user/models/pass_model.dart';
import '../../../../auth/models/permission_model4.dart';
import '../../../../challenge/models/promo_model.dart';
import '../../../../tests/models/test_model.dart';
import '../../../controllers/nachislenie_controller.dart';
import 'act_download_card.dart';

class ActIssuingPrize extends StatelessWidget {
  ActIssuingPrize(
      {Key key,
      this.withdrawalId,
      this.testModel,
      this.passModel,
      this.promoModel,
      this.model})
      : super(key: key);
  final PromoModel promoModel;
  final PassModel passModel;
  final PermissionModel4 model;
  final TestModel testModel;
  String withdrawalId;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<NachislenieController>(
        init: NachislenieController(),
        builder: (controller) {
          return Scaffold(
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.asset(
                  'assets/images/label_background.png',
                  fit: BoxFit.fitWidth,
                ),
                Container(
                  height: size.height * .78,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, top: 15, right: 15),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: size.width / 3.5),
                                  child: const CommonTextWidget(
                                    text: 'Загрузите акт',
                                    fontFamily: 'Arial',
                                    size: 18,
                                    color: Color(0xff49536D),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const Spacer(),
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
                                        child: Center(
                                          child: Icon(
                                            Icons.close,
                                            color: Color(0xff49536D),
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.01),
                            const CommonTextWidget(
                              text: 'Описание действий для пользователя',
                              size: 16,
                              fontFamily: 'Arial',
                              color: Color(0xff49536D),
                              fontWeight: FontWeight.w400,
                            ),
                            SizedBox(height: size.height * 0.026),
                            InkWell(
                              onTap: controller.isLoadingShare
                                  ? null
                                  : () async {
                                      controller.showFile(
                                          context, withdrawalId);
                                      // ApiServiceHome
                                    },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: const Color(0xffF9F9F9),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xff1D1D1D)
                                          .withOpacity(0.1),
                                      spreadRadius: 0,
                                      blurRadius: 5,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 15,
                                      top: size.height * 0.02,
                                      bottom: size.height * 0.02),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 55,
                                        height: 55,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              spreadRadius: 0,
                                              blurRadius: 0,
                                              color: const Color(0xff0025C2)
                                                  .withOpacity(0.1),
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Center(
                                          child: controller.isLoadingShare
                                              ? const CircularProgressIndicator(
                                                  color: kGlobal,
                                                )
                                              : const Icon(
                                                  Icons
                                                      .insert_drive_file_outlined,
                                                  color: kGlobal,
                                                ),
                                        ),
                                      ),
                                      const SizedBox(width: 24),
                                      const SizedBox(
                                        height: 30,
                                        child: CommonTextWidget(
                                          text: 'Посмотреть акт',
                                          fontFamily: 'Arial',
                                          fontWeight: FontWeight.w400,
                                          size: 16,
                                          color: kGlobal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 14),
                            InkWell(
                              onTap: () {
                                controller.sendEmail(context, withdrawalId);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: const Color(0xffF9F9F9),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xff1D1D1D)
                                          .withOpacity(0.1),
                                      spreadRadius: 0,
                                      blurRadius: 5,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 15,
                                      top: size.height * 0.02,
                                      bottom: size.height * 0.02),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 55,
                                        height: 55,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              spreadRadius: 0,
                                              blurRadius: 0,
                                              color: const Color(0xff0025C2)
                                                  .withOpacity(0.1),
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Center(
                                          child: controller.isLoadingSendEmail
                                              ? const CircularProgressIndicator(
                                                  color: kGlobal,
                                                )
                                              : const Icon(
                                                  Icons.email,
                                                  color: kGlobal,
                                                ),
                                        ),
                                      ),
                                      const SizedBox(width: 24),
                                      const CommonTextWidget(
                                        text:
                                            'Получите акт на почту,\nуказанную в профиле',
                                        fontWeight: FontWeight.w400,
                                        size: 16,
                                        fontFamily: 'Arial',
                                        color: kGlobal,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            /// Act №1
                            const SizedBox(height: 14),
                            ActDownloadCard(
                              controller: controller,
                              text: controller.selectedFiles.isEmpty
                                  ? 'Загрузить \nподписанный акт, файл 1'
                                  : controller.selectedFiles[0].path
                                      .split('/')
                                      .last,
                              size: size,
                              onTap: () {
                                controller.getFile(context: context, index: 0);
                              },
                            ),

                            /// Act №2
                            const SizedBox(height: 14),
                            ActDownloadCard(
                              controller: controller,
                              text: controller.selectedFiles.length > 1
                                  ? controller.selectedFiles[1].path
                                      .split('/')
                                      .last
                                  : 'Загрузить \nподписанный акт, файл 2 \n(при наличии)',
                              size: size,
                              onTap: () {
                                if (controller.selectedFiles.isNotEmpty) {
                                  controller.getFile(
                                      context: context, index: 1);
                                } else {
                                  CustomSnackBar.badSnackBar(
                                      context, 'Загрузите файл 1');
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      //const Spacer(),
                      /// Button send check
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 5),
                        child: Opacity(
                          opacity: controller.selectedFiles.isEmpty ? 0.3 : 1,
                          child: Material(
                            elevation: 3,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                              ),
                            ),
                            color: const Color(0xff13971E),
                            child: InkWell(
                              onTap: () {
                                controller.sendFile(context, withdrawalId,
                                    model, passModel, promoModel, testModel);
                              },
                              child: SizedBox(
                                height: 80,
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const CommonTextWidget(
                                        text: 'Отправить на проверку',
                                        fontWeight: FontWeight.w700,
                                        size: 16,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 7, right: 5),
                                        child: SizedBox(
                                          width: 15,
                                          height: 15,
                                          child: controller.isLoadingSendFile
                                              ? const CircularProgressIndicator(
                                                  color: Colors.white,
                                                )
                                              : const Icon(
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
                  ),
                ),
              ],
            ),
          );
        });
  }
}
