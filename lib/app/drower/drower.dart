import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/home/controllers/home_controller.dart';
import 'package:teklub/tests/models/test_model.dart';

import '../routes/route.dart';
import '/app/routes/route.dart' as route;
import '../../auth/controller/reg_form_controller.dart';
import '../../auth/models/permission_model4.dart';
import '../../challenge/models/promo_model.dart';
import '../../home/views/screens/money/get_money_screen.dart';
import '../theme.dart';
import '../user/models/pass_model.dart';

class DrawerApp extends StatefulWidget {
  final String promoType;
  final TestModel testModel;
  final PermissionModel4 model;
  final PassModel passModel;
  final PromoModel promoModel;

  const DrawerApp(
      {Key key,
      this.promoType,
      this.testModel,
      this.model,
      this.passModel,
      this.promoModel})
      : super(key: key);

  @override
  State<DrawerApp> createState() => _DrawerAppState();
}

class _DrawerAppState extends State<DrawerApp> {
  bool getTests() {
    bool empty = widget.testModel.data.isNotEmpty;
    bool falseContain;
    for (var element in widget.testModel.data) {
      if (element.canPassed == true) {
        falseContain = true;
      }
    }
    return empty == true && falseContain == true ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          controller.countActionNoti();
          return SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 30, top: 5, left: 15, bottom: 5),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.9,
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0, top: 10),
                    child: ListView(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.close),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Image.asset(
                                'assets/images/drower.png',
                              ),
                            ),
                            const SizedBox(
                              width: 60,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 5),
                          child: Material(
                            color: controller.currentHomePage == 'main'
                                ? kGlobal
                                : Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                controller.currentPageChange('main');
                                Navigator.pop(context);
                              },
                              child: ListTile(
                                leading: Icon(
                                  Icons.home,
                                  color: controller.currentHomePage == 'main'
                                      ? Colors.white
                                      : kGlobal,
                                ),
                                title: CommonTextWidget(
                                  text: 'Главная',
                                  size: 16,
                                  fontFamily: 'Arial',
                                  color: controller.currentHomePage == 'main'
                                      ? Colors.white
                                      : ThemeSettings.primaryColorText,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // if (widget.promoType == 'challenge')
                        //   Padding(
                        //     padding: const EdgeInsets.only(
                        //         left: 15, right: 15, bottom: 5),
                        //     child: Material(
                        //       color: controller.currentHomePage == 'challenge'
                        //           ? kGlobal
                        //           : Colors.white,
                        //       shape: const RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.all(
                        //           Radius.circular(12),
                        //         ),
                        //       ),
                        //       child: InkWell(
                        //         onTap: () {
                        //           controller.currentPageChange('challenge');
                        //           Navigator.pop(context);
                        //         },
                        //         child: ListTile(
                        //           leading: Icon(
                        //             Icons.new_releases,
                        //             color: controller.currentHomePage ==
                        //                     'challenge'
                        //                 ? Colors.white
                        //                 : kGlobal,
                        //           ),
                        //           title: CommonTextWidget(
                        //             text: 'Челендж',
                        //             size: 16,
                        //             color: controller.currentHomePage ==
                        //                     'challenge'
                        //                 ? Colors.white
                        //                 : const Color(0xff49536D),
                        //             fontWeight: FontWeight.w700,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //       left: 15, right: 15, bottom: 5),
                        //   child: Material(
                        //     color: const Color(0xffffffff),
                        //     shape: const RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.all(
                        //         Radius.circular(12),
                        //       ),
                        //     ),
                        //     child: InkWell(
                        //       onTap: () {},
                        //       child: const ListTile(
                        //         leading: Icon(
                        //           Icons.new_releases,
                        //           color: kGlobal,
                        //         ),
                        //         title: CommonTextWidget(
                        //           text: 'Новости',
                        //           size: 16,
                        //           color: Color(0xff49536D),
                        //           fontWeight: FontWeight.w700,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // if (getTests())
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 5),
                          child: Material(
                            color: controller.currentHomePage == 'tests'
                                ? kGlobal
                                : Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                controller.currentPageChange('tests');
                                Navigator.pushNamed(context, homeScreen);
                              },
                              child: ListTile(
                                leading: Icon(
                                  Icons.school,
                                  color: controller.currentHomePage == 'tests'
                                      ? Colors.white
                                      : kGlobal,
                                ),
                                title: CommonTextWidget(
                                  text: 'Тесты и опросы',
                                  size: 16,
                                  fontFamily: 'Arial',
                                  color: controller.currentHomePage == 'tests'
                                      ? Colors.white
                                      : const Color(0xff49536D),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //       left: 15, right: 15, bottom: 5),
                        //   child: Material(
                        //     color: const Color(0xffffffff),
                        //     shape: const RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.all(
                        //         Radius.circular(12),
                        //       ),
                        //     ),
                        //     child: InkWell(
                        //       onTap: () {},
                        //       child: const ListTile(
                        //         leading: Icon(
                        //           Icons.monetization_on,
                        //           color: kGlobal,
                        //         ),
                        //         title: CommonTextWidget(
                        //           text: 'Ценомониторинг',
                        //           size: 16,
                        //           color: Color(0xff49536D),
                        //           fontWeight: FontWeight.w700,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //       left: 15, right: 15, bottom: 5),
                        //   child: Material(
                        //     color: controller.currentHomePage == 'invite'
                        //         ? kGlobal
                        //         : Colors.white,
                        //     shape: const RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.all(
                        //         Radius.circular(12),
                        //       ),
                        //     ),
                        //     child: InkWell(
                        //       onTap: () {
                        //         controller.currentPageChange('invite');
                        //         Navigator.pop(context);
                        //       },
                        //       child: ListTile(
                        //         leading: SvgPicture.asset(
                        //           'assets/images/person.svg',
                        //           semanticsLabel: 'Acme Logo',
                        //           color: controller.currentHomePage == 'invite'
                        //               ? Colors.white
                        //               : kGlobal,
                        //         ),
                        //         title: CommonTextWidget(
                        //           text: 'Пригласи друга',
                        //           size: 16,
                        //           color: controller.currentHomePage == 'invite'
                        //               ? Colors.white
                        //               : const Color(0xff49536D),
                        //           fontWeight: FontWeight.w700,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 5),
                          child: Material(
                            color: controller.currentHomePage == 'action'
                                ? kGlobal
                                : Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                controller.currentPageChange('action');
                                Navigator.pushNamed(context, homeScreen);
                              },
                              child: ListTile(
                                leading: SvgPicture.asset(
                                  'assets/images/action.svg',
                                  semanticsLabel: 'Acme Logo',
                                  color: controller.currentHomePage == 'action'
                                      ? Colors.white
                                      : kGlobal,
                                ),
                                title: CommonTextWidget(
                                  text: 'Текущие акции',
                                  size: 16,
                                  fontFamily: 'Arial',
                                  color: controller.currentHomePage == 'action'
                                      ? Colors.white
                                      : const Color(0xff49536D),
                                  fontWeight: FontWeight.w400,
                                ),
                                trailing: controller.checkShowAction() &&
                                        controller.countAction != 0
                                    ? CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Color(0xffF29200),
                                        child: CommonTextWidget(
                                          text: '${controller.countAction}',
                                          size: 14,
                                          color: Color(0XFFFFFFFF),
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 5),
                          child: Material(
                            color: controller.currentHomePage == 'faq'
                                ? kGlobal
                                : Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                controller.currentPageChange('faq');
                                Navigator.pop(context);
                                Navigator.pushNamed(context, homeScreen);
                              },
                              child: ListTile(
                                leading: Icon(Icons.info_outline,
                                    color: controller.currentHomePage == 'faq'
                                        ? Colors.white
                                        : kGlobal),
                                title: CommonTextWidget(
                                  text: 'Вопросы и ответы',
                                  size: 16,
                                  fontFamily: 'Arial',
                                  color: controller.currentHomePage == 'faq'
                                      ? Colors.white
                                      : const Color(0xff49536D),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 5),
                          child: Material(
                            color: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                AppMetrica.reportEvent(
                                  'sbalance',
                                );
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                    context, route.nachislenieScreen);
                              },
                              child: ListTile(
                                leading: SvgPicture.asset(
                                  'assets/images/icon1.svg',
                                  semanticsLabel: 'icon11',
                                  height: 25,
                                  color: kGlobal,
                                  width: 25,
                                ),
                                title: const CommonTextWidget(
                                  text: 'Начисления',
                                  size: 16,
                                  fontFamily: 'Arial',
                                  color: Color(0xff49536D),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 5),
                          child: Material(
                            color: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                AppMetrica.reportEvent(
                                  'pay_points_sidebar',
                                );
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GetMoneyScreen(
                                      model: widget.model,
                                      passModel: widget.passModel,
                                      promoModel: widget.promoModel,
                                      testModel: widget.testModel,
                                    ),
                                  ),
                                );
                                // if (widget.model.data.permissions.withdrawals
                                //     .contains('add')) {
                                //
                                // } else {
                                //   CustomSnackBar.badSnackBar(
                                //       context, 'Вывод средств недоступен.');
                                // }
                              },
                              child: ListTile(
                                leading: SvgPicture.asset(
                                  'assets/images/icon2.svg',
                                  semanticsLabel: 'icon11',
                                  height: 25,
                                  color: kGlobal,
                                  width: 25,
                                ),
                                title: const CommonTextWidget(
                                  text: 'Потратить баллы',
                                  size: 16,
                                  fontFamily: 'Arial',
                                  color: Color(0xff49536D),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        // const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 5),
                          child: Material(
                            color: const Color(0xffF9F9F9),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            child: GetBuilder<RegFormController>(
                                init: RegFormController(),
                                builder: (controllers) {
                                  return InkWell(
                                    onTap: () async {
                                      await controllers.getSpecs(context);
                                      Get.delete<RegFormController>(
                                          force: true);
                                      Navigator.pushNamed(
                                          context, route.userSettingsScreen);
                                    },
                                    child: const ListTile(
                                      leading: Icon(
                                        Icons.person,
                                        color: kGlobal,
                                      ),
                                      title: CommonTextWidget(
                                        text: 'Настройки профиля',
                                        size: 16,
                                        fontFamily: 'Arial',
                                        color: Color(0xff49536D),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Material(
                            color: const Color(0xffF9F9F9),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            child: InkWell(
                              onTap: () async {
                                controller.userController.logoutMenu(context);
                              },
                              child: const ListTile(
                                leading: Icon(
                                  Icons.logout,
                                  color: kGlobal,
                                ),
                                title: CommonTextWidget(
                                  text: 'Выйти',
                                  size: 16,
                                  color: Color(0xff49536D),
                                  fontFamily: 'Arial',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 15, top: 12),
                          child: Material(
                            color: const Color(0xffF9F9F9),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            child: InkWell(
                              onTap: () async {
                                controller.userController
                                    .deleteAccount(context);
                                //controller.userController.logoutMenu(context);
                              },
                              child: ListTile(
                                leading: Padding(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: SvgPicture.asset(
                                    'assets/images/delete.svg',
                                    color: Colors.red,
                                    height: 21,
                                    width: 21,
                                  ),
                                ),
                                title: const CommonTextWidget(
                                  text: 'Удалить аккаунт',
                                  size: 16,
                                  color: Colors.red,
                                  fontFamily: 'Arial',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
