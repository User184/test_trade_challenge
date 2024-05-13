import 'package:get/get.dart';
import 'package:teklub/auth/controller/reg_form_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegFormController(), fenix: true);
  }
}
