import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../app/common/components/snack_bar.dart';
import '../../home/controllers/home_controller.dart';
import '../data/api_service_action.dart';
import '../models/actions_model.dart';



class ActionsController extends GetxController {

  ActionsController(){
    GetStorage().write('countAction', Get.put(HomeController()).countAction);
    GetStorage().write('showAction', true);
  }


}
