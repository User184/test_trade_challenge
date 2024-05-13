import 'package:get/get.dart';
import 'package:teklub/auth/data/api_setting.dart';
import 'package:teklub/auth/models/permission_model4.dart';

class StartAppController extends GetxController {
  static StartAppController instance = Get.find();

  bool userAccess = false;

  getPermissions() async {
    final PermissionModel4 result = await ApiSetting.getPermissions();
    userAccess = true;
    update();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getPermissions();
  }
}
