import 'dart:io';

import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:teklub/app/theme.dart';
import 'package:teklub/home/views/widgets/home_mane_widgets/user_element_widget2.dart';

import '../../../../app/drower/drower.dart';
import '../../../../app/user/data/api_setting_user.dart';
import '../../../../app/user/models/get_profile_data_model.dart';
import '../../../../app/user/models/pass_model.dart';
import '../../../../auth/controller/reg_form_controller.dart';
import '../../../../auth/data/api_service.dart';
import '../../../../auth/models/permission_model4.dart';
import '../../../../auth/models/wlk_screen_model.dart';
import '../../../../auth/onboarding_screen/screens/onboarding_screen.dart';
import '../../../../auth/view/screens/update_screen.dart';
import '../../../../challenge/models/promo_model.dart';
import '../../../../tests/models/test_model.dart';
import '../../../controllers/home_controller.dart';
import '../../../notofiaction/views/screens/msg_screen.dart';
import 'actions_widget.dart';
import 'any_quastion_widget.dart';
import 'app_bar_money_widget.dart';
import 'main_box_widget.dart';

class HomeMainWidget extends StatefulWidget {
  final PermissionModel4 modelMe;
  final TestModel modelTest;
  final PromoModel promoDetail;
  final PassModel passModel;
  final GetProfileDataModel getProfileDataModel;
  final bool isFirst;

  const HomeMainWidget({
    Key key,
    this.modelMe,
    this.modelTest,
    this.promoDetail,
    this.passModel,
    this.getProfileDataModel,
    this.isFirst = false,
  }) : super(key: key);

  @override
  State<HomeMainWidget> createState() => _HomeMainWidgetState();
}

class _HomeMainWidgetState extends State<HomeMainWidget>
    with WidgetsBindingObserver {
  // Future<WlkScreen> wlkScreen=ApiSettingUser.checkWelcomeScreens(true);

  @override
  didChangeAppLifecycleState(AppLifecycleState state) async {
    print(state.toString());
    if (ModalRoute.of(context)?.isCurrent == true) {
      switch (state) {
        case AppLifecycleState.resumed:
          await handelBackground();
          break;
        case AppLifecycleState.inactive:
          print('app inactive');
          break;
        case AppLifecycleState.paused:
          print('app inactivsssssse');
          // TODO: Handle this case.
          break;
        case AppLifecycleState.detached:
          print('sd insdsdsddsactive');
          break;
      }
    }
  }

  Future<WlkScreen> checkWelcomeScreens;

  Future handelBackground() async {
    GetStorage storage = GetStorage();
    String token = await storage.read('token');

    if (token != null && Get.put(HomeController()).currentHomePage == 'main') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeMainWidget(
            modelMe: widget.modelMe,
            modelTest: widget.modelTest,
            promoDetail: widget.promoDetail,
            passModel: widget.passModel,
            getProfileDataModel: widget.getProfileDataModel,
          ),
        ),
      );
    }
  } //9148941557

  bool getTests() {
    bool empty = widget.modelTest.data.isNotEmpty;
    bool falseContain;
    for (var element in widget.modelTest.data) {
      if (element.canPassed == true) {
        falseContain = true;
      }
    }
    return empty == true && falseContain == true ? true : false;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchVersion();
    });

    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Get.put(HomeController()).changeShowOnBoardingScreen();
  }

  @override
  void dispose() {
    Get.put(HomeController()).changeShowOnBoardingScreen();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  String platform;

  void fetchVersion() async {
    if (Platform.isAndroid) {
      platform = "android";
    } else {
      platform = "ios";
    }
    try {
      var res = await APIServiceAuth.checkVersionApp(platform);
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String version = packageInfo.version;
      print('versionversion$version');
      if (version != null) {
        final fcmToken = await FirebaseMessaging.instance.getToken();
        if (fcmToken != null) {
          await APIServiceAuth.sendVersionApp(version, fcmToken);
        }

        if (version.compareTo(res) < 0) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const UpdateScreen()));
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isFirst) {
      print("dfd");
      checkWelcomeScreens = ApiSettingUser.checkWelcomeScreens(true);
      return FutureBuilder<WlkScreen>(
        future: checkWelcomeScreens,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.data.isNotEmpty) {
              return OnBoardingScreen(
                  welcomeScreenModel: snapshot.data,
                  isStart: false,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeMainCustomer(
                                  modelMe: widget.modelMe,
                                  modelTest: widget.modelTest,
                                  promoDetail: widget.promoDetail,
                                  passModel: widget.passModel,
                                  getProfileDataModel:
                                      widget.getProfileDataModel,
                                )));
                  });
            } else {
              return HomeMainCustomer(
                modelMe: widget.modelMe,
                modelTest: widget.modelTest,
                promoDetail: widget.promoDetail,
                passModel: widget.passModel,
                getProfileDataModel: widget.getProfileDataModel,
              );
            }
          }
          if (snapshot.hasError) {
            return HomeMainCustomer(
              modelMe: widget.modelMe,
              modelTest: widget.modelTest,
              promoDetail: widget.promoDetail,
              passModel: widget.passModel,
              getProfileDataModel: widget.getProfileDataModel,
            );
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                  color: kGlobal, backgroundColor: Colors.white),
            ),
          );
        },
      );
    } else {
      return HomeMainCustomer(
        modelMe: widget.modelMe,
        modelTest: widget.modelTest,
        promoDetail: widget.promoDetail,
        passModel: widget.passModel,
        getProfileDataModel: widget.getProfileDataModel,
      );
    }
  }
}

class HomeMainCustomer extends StatefulWidget {
  final PermissionModel4 modelMe;
  final TestModel modelTest;
  final PromoModel promoDetail;
  final PassModel passModel;

  final GetProfileDataModel getProfileDataModel;
  final WlkScreen wel;

  const HomeMainCustomer({
    Key key,
    this.modelMe,
    this.modelTest,
    this.promoDetail,
    this.passModel,
    this.getProfileDataModel,
    this.wel,
  }) : super(key: key);

  @override
  State<HomeMainCustomer> createState() => _HomeMainCustomerState();
}

class _HomeMainCustomerState extends State<HomeMainCustomer> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        autoRemove: false,
        builder: (controller) {
          return Scaffold(
            backgroundColor: const Color(0xffF9F9F9),
            drawer: SizedBox(
              width: double.infinity,
              child: Drawer(
                child: DrawerApp(
                  promoType: widget.modelMe.data.promo.type,
                  //testModel: modelTest,
                  model: widget.modelMe,
                  passModel: widget.passModel,
                  promoModel: widget.promoDetail,
                ),
                backgroundColor: kGlobalBlack,
              ),
            ),
            appBar: AppBar(
              actions: [
                AppBarMoneyWidget(
                  color: 0xff49536D,
                  permissionModel4: widget.modelMe ?? PermissionModel4(),
                ),
                Obx(() {
                  print('object');
                  return IconButton(
                    onPressed: () {
                      // Get.put(RegFormController()).showDialogPromoCode(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MsgScreen()),
                      );
                    },
                    icon: Stack(
                      children: [
                        if (controller.msgCount.value != 0)
                          RotationTransition(
                            turns: const AlwaysStoppedAnimation(-40 / 360),
                            child: Icon(
                              CupertinoIcons.bell,
                              color: controller.currentHomePage == 'main' ||
                                      controller.currentHomePage == 'catalog' ||
                                      controller.currentHomePage == 'tests' ||
                                      controller.currentHomePage ==
                                          'challenge' ||
                                      controller.currentHomePage == 'action' ||
                                      controller.currentHomePage ==
                                          'gift_catalog'
                                  ? const Color(0xff49536D)
                                  : Colors.white,
                            ),
                          ),
                        if (controller.msgCount.value == 0)
                          Icon(
                            CupertinoIcons.bell,
                            color: controller.currentHomePage == 'main' ||
                                    controller.currentHomePage == 'catalog' ||
                                    controller.currentHomePage == 'tests' ||
                                    controller.currentHomePage == 'challenge' ||
                                    controller.currentHomePage == 'action' ||
                                    controller.currentHomePage == 'gift_catalog'
                                ? const Color(0xff49536D)
                                : Colors.white,
                          ),
                        if (controller.msgCount.value != 0)
                          Positioned(
                            top: 15,
                            left: 3,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.deepOrangeAccent,
                                shape: BoxShape.circle,
                              ),
                              height: 8,
                              width: 9,
                            ),
                          ),
                      ],
                    ),
                  );
                }),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: UserElementWidget(
                      name: widget.modelMe.data.name,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                    child: MainBoxWidget(
                      modelMe: widget.modelMe,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        ActionWidget(
                          model: widget.modelMe,
                          passModel: widget.passModel,
                          promoModel: widget.promoDetail,
                          testMode: widget.modelTest,
                        ),
                        InkWell(
                          onTap: () {
                            AppMetrica.reportEvent(
                              'tech',
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 40, top: 20),
                            child: AnyQuestionWidget(
                              numberPhone:
                                  widget.getProfileDataModel.data.phone,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // const NewsCaruselWidget(),

                  // const PriceMonitoringCaruselWidget(),
                ],
              ),
            ),
          );
        });
  }
}
