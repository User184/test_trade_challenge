import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_save/image_save.dart';
import 'package:teklub/app/drower/drower.dart';
import 'package:teklub/app/user/data/api_setting_user.dart';
import 'package:teklub/app/user/models/pass_model.dart';
import 'package:teklub/challenge/data/promo_api.dart';
import 'package:teklub/challenge/models/promo_model.dart';
import 'package:teklub/home/controllers/home_controller.dart';
import 'package:teklub/home/views/widgets/home_mane_widgets/app_bar_money_widget.dart';
import 'package:teklub/tests/data/test_services.dart';

import '../../../app/common/components/common_text_widget.dart';
import '../../../app/theme.dart';
import '../../../app/user/models/get_profile_data_model.dart';
import '../../../auth/data/api_setting.dart';
import '../../../auth/models/permission_model4.dart';
import '../../../tests/models/test_model.dart';
import '../../notofiaction/views/screens/msg_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key, this.isFirst = false}) : super(key: key);

  final bool isFirst;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Uint8List saveAvatar;

  Future<void> getImageFromSandBox() async {
    try {
      List<Uint8List> files =
          await ImageSave.getImagesFromSandbox().catchError((e) {
        print(e);
      });
      if (files != null) {
        saveAvatar = files[0];
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  setEnter() async {
    var res = await ApiSettingUser.setEnter();
    print('1111');
    print(res);
  }

  GetStorage storage = GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getImageFromSandBox();
    setEnter();
  }

  final Future<PermissionModel4> getPermissions = ApiSetting.getPermissions();
  final Future<PromoModel> getPromoData = ApiPromo.getPromoData();
  final Future<PassModel> getPassportData = ApiSettingUser.getPassportData();
  final Future<GetProfileDataModel> getProfileDataModel =
      ApiSettingUser.getProfileData();
  final Future<TestModel> getTests = ApiServiceTest.getTests();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([
          getPermissions,
          getTests,
          getPromoData,
          getPassportData,
          getProfileDataModel,
        ]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            PermissionModel4 modelMe = snapshot.data[0];
            TestModel modelTest = snapshot.data[1];
            PromoModel promoDetail = snapshot.data[2];
            PassModel passModel = snapshot.data[3];
            GetProfileDataModel profileDataModel = snapshot.data[4];
            return GetBuilder<HomeController>(
                init: HomeController(),
                autoRemove: false,
                builder: (controller) {
                  return Scaffold(
                    drawer: SizedBox(
                      width: double.infinity,
                      child: Drawer(
                        child: DrawerApp(
                          promoType: modelMe.data.promo.type,
                          testModel: modelTest,
                          model: modelMe,
                          passModel: passModel,
                          promoModel: promoDetail,
                        ),
                        backgroundColor: kGlobalBlack,
                      ),
                    ),
                    backgroundColor: const Color(0xffF9F9F9),
                    appBar: controller.currentHomePage != "invite" &&
                            controller.currentHomePage != "main"
                        ? AppBar(
                            centerTitle: true,
                            backgroundColor: controller.setAppBarColor(),
                            title: controller.currentHomePage == 'tests'
                                ? const CommonTextWidget(
                                    text: '',
                                    size: 20,
                                    color: Color(0xff49536D),
                                    fontWeight: FontWeight.w700,
                                  )
                                : controller.currentHomePage == 'challenge'
                                    ? const CommonTextWidget(
                                        text: 'Челендж',
                                        size: 20,
                                        color: Color(0xff49536D),
                                        fontWeight: FontWeight.w700,
                                      )
                                    : AppBarMoneyWidget(
                                        color: 0xff49536D,
                                        permissionModel4:
                                            modelMe ?? PermissionModel4(),
                                      ),
                            iconTheme: IconThemeData(
                                color: controller.currentHomePage == 'main' ||
                                        controller.currentHomePage ==
                                            'catalog' ||
                                        controller.currentHomePage == 'tests' ||
                                        controller.currentHomePage ==
                                            'challenge' ||
                                        controller.currentHomePage ==
                                            'action' ||
                                        controller.currentHomePage ==
                                            'gift_catalog'
                                    ? const Color(0xff49536D)
                                    : Colors.white),
                            actions: [
                              Obx(() {
                                return IconButton(
                                  onPressed: () {
                                    // Get.put(RegFormController()).showDialogPromoCode(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MsgScreen()),
                                    );
                                  },
                                  icon: Stack(
                                    children: [
                                      if (controller.msgCount.value != 0)
                                        RotationTransition(
                                          turns: const AlwaysStoppedAnimation(
                                              -40 / 360),
                                          child: Icon(
                                            CupertinoIcons.bell,
                                            color: controller.currentHomePage ==
                                                        'main' ||
                                                    controller
                                                            .currentHomePage ==
                                                        'catalog' ||
                                                    controller
                                                            .currentHomePage ==
                                                        'tests' ||
                                                    controller
                                                            .currentHomePage ==
                                                        'challenge' ||
                                                    controller
                                                            .currentHomePage ==
                                                        'action' ||
                                                    controller
                                                            .currentHomePage ==
                                                        'gift_catalog'
                                                ? const Color(0xff49536D)
                                                : Colors.white,
                                          ),
                                        ),
                                      if (controller.msgCount.value == 0)
                                        Icon(
                                          CupertinoIcons.bell,
                                          color: controller.currentHomePage ==
                                                      'main' ||
                                                  controller.currentHomePage ==
                                                      'catalog' ||
                                                  controller.currentHomePage ==
                                                      'tests' ||
                                                  controller.currentHomePage ==
                                                      'challenge' ||
                                                  controller.currentHomePage ==
                                                      'action' ||
                                                  controller.currentHomePage ==
                                                      'gift_catalog'
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
                              })
                            ],
                          )
                        : null,
                    body: controller.mainPageConstructor(
                        modelMe ?? PermissionModel4(),
                        modelTest ?? TestModel(),
                        promoDetail ?? PromoModel(),
                        passModel ?? PassModel(),
                        profileDataModel ?? GetProfileDataModel(),
                        widget.isFirst),
                  );
                });
          }
          return const Scaffold(
            backgroundColor: kGlobalBlack,
            body: Center(
              child: CircularProgressIndicator(
                  color: kGlobal, backgroundColor: Colors.white),
            ),
          );
        });
  }
}
