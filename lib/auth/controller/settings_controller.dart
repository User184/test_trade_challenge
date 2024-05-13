import 'package:get/get.dart';
import 'package:teklub/auth/data/api_setting.dart';
import 'package:teklub/auth/models/get_files_models.dart';
import 'package:teklub/auth/models/wlk_screen_model.dart';

class SettingsController extends GetxController {
  bool smsScreen = false;
  Future<GetFilesModels> getFiles() async {
    GetFilesModels result = await ApiSetting.filesGet();

    return result;
  }

  Future<WlkScreen> getWelcomeScreen() async {
    WlkScreen result = await ApiSetting.getWelcomeScreens();

    return result;
  }
}
