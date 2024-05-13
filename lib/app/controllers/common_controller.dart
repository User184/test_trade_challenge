import 'package:get/get.dart';

import '../../auth/models/permission_model4.dart';

class CommonController extends GetxController {
  Rx<PermissionModel4> permissionModel4 = Rx<PermissionModel4>(null);

  setPermissionModel4(PermissionModel4 item) {
    permissionModel4.value = item;
  }
}
