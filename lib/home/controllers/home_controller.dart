import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_save/image_save.dart';
import 'package:teklub/app/user/controllers/user_controller.dart';
import 'package:teklub/app/user/models/pass_model.dart';
import 'package:teklub/auth/data/api_setting.dart';
import 'package:teklub/auth/models/get_files_models.dart';
import 'package:teklub/auth/models/permission_model4.dart';
import 'package:teklub/challenge/models/promo_model.dart';
import 'package:teklub/challenge/views/screens/challenge_screen.dart';
import 'package:teklub/home/data/api_service_home.dart';
import 'package:teklub/home/models/api_models/faq_model.dart';
import 'package:teklub/home/views/screens/faq/faq_screen.dart';
import 'package:teklub/home/views/widgets/home_mane_widgets/home_main_widget.dart';
import 'package:teklub/tests/models/test_model.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../action/data/api_service_action.dart';
import '../../action/models/actions_model.dart';
import '../../action/view/screens/action_screen.dart';
import '../../app/theme.dart';
import '../../app/user/models/get_profile_data_model.dart';
import '../../catalog/views/screens/catalog_screen.dart';
import '../../referral/views/screens/referral_friend_screen.dart';
import '../../tests/views/screens/test_screen.dart';
import '../notofiaction/data/api_service_notification.dart' as notif;
import '../notofiaction/models/msg_model.dart' as notifModel;

class HomeController extends GetxController {
  final UserController userController = Get.put(UserController());
  bool isShowOnBoardingScreen = true;
  Rx<PermissionModel4> me = Rx<PermissionModel4>(null);
  void changeShowOnBoardingScreen() {
    isShowOnBoardingScreen = true;
    // update();
  }

  Rx<Uint8List> avatar = Rx<Uint8List>(null);

  GetStorage storage = GetStorage();

  Future<void> getImageFromSandBox() async {
    try {
      List<Uint8List> files = await ImageSave.getImagesFromSandbox();
      if (files.isNotEmpty) {
        print(files);
        avatar.value = files[0];
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  setUpMe(data) async {
    me.value = data;
  }

  void countActionNoti() async {
    try {
      final res = await ApiServiceAction.getAction();
      if (res is ActionsModel) {
        countAction = res.data.length;
      }
    } catch (e) {
      countAction = 0;
    }
    checkShowAction();
  }

  bool checkShowAction() {
    if (storage.read('showAction') == null) {
      storage.write('showAction', false);
      storage.write('countAction', countAction);
      return true;
    } else {
      if ((countAction != storage.read('countAction'))) {
        if (countAction > storage.read('countAction')) {
          countAction -= storage.read('countAction');
        }
        return true;
      } else {
        if (storage.read('showAction')) {
          return false;
        } else {
          return true;
        }
      }
    }
  }

  RxBool addMoneyLoading = RxBool(false);

  var panelController = PanelController();

  String currentHomePage = 'main';

  int countAction = 0;

  bool isShowAction = true;

  void currentPageChange(String item) {
    currentHomePage = item;
    update();
  }

  Color setAppBarColor() {
    if (currentHomePage == 'main') {
      return const Color(0xffF9F9F9);
    } else if (currentHomePage == 'faq') {
      return kGlobalBlack;
    } else if (currentHomePage == 'catalog') {
      return const Color(0xffffffff);
    } else if (currentHomePage == 'tests') {
      return const Color(0xffF3F7FF);
    } else if (currentHomePage == 'challenge') {
      return const Color(0xffffffff);
    } else if (currentHomePage == 'action') {
      return const Color(0xffF9F9F9);
    } else if (currentHomePage == 'gift_catalog') {
      return const Color(0xffF3F7FF);
    }
    return const Color(0xffffffff);
  }

  Widget mainPageConstructor(
      PermissionModel4 modelMe,
      TestModel modelTest,
      PromoModel promoDetail,
      PassModel passModel,
      GetProfileDataModel getProfileDataModel,
      bool isFirst) {
    if (currentHomePage == 'faq') {
      return const FaqScreen();
    } else if (currentHomePage == 'catalog') {
      return const CatalogScreen();
    } else if (currentHomePage == 'tests') {
      return const TestScreen();
    } else if (currentHomePage == 'challenge') {
      return ChallengeScreen(
        promoDetail: promoDetail,
      );
    } else if (currentHomePage == 'invite') {
      return const ReferralFriendScreen();
    } else if (currentHomePage == 'action') {
      return const ActionScreen();
    }
    return HomeMainWidget(
        modelMe: modelMe,
        modelTest: modelTest,
        promoDetail: promoDetail,
        passModel: passModel,
        getProfileDataModel: getProfileDataModel,
        isFirst: isFirst);
  }

  Future<List<FaqFileModel>> getFaqFiles() async {
    GetFilesModels result = await ApiServiceHome.filesGet();
    List<FaqFileModel> resultList = [];
    for (var element in result.data) {
      resultList.add(
        FaqFileModel(type: element.type, url: element.url),
      );
    }
    return resultList;
  }

  Future<List<FaqModelUi>> getFaqData() async {
    FaqModel result = await ApiServiceHome.getFaqList();
    List<FaqModelUi> resultList = [];
    for (var element in result.data) {
      resultList.add(
        FaqModelUi(title: element.title, text: element.body),
      );
    }
    return resultList;
  }

  PermissionModel4 permissions;

  getPermissions() async {
    PermissionModel4 result = await ApiSetting.getPermissions();
    permissions = result;
    update();
  }

  RxList<notifModel.Data> msgList = RxList<notifModel.Data>([]);
  RxInt msgCount = RxInt(0);
  checkMsg() async {
    try {
      notifModel.MsgModel result =
          await notif.ApiServiceNotification.filesNotification();
      msgList.value = result.data;
      if (msgList != null) {
        msgCount.value = msgList.where((p0) => p0.read == null).length;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    Timer.periodic(const Duration(seconds: 15), (timer) {
      if (msgList.value.isEmpty) checkMsg();
    });
    super.onReady();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPermissions();
    if (avatar.value == null) {
      getImageFromSandBox();
    }
  }
}
