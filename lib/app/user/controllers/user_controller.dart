import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:teklub/app/user/data/api_setting_user.dart';
import 'package:teklub/app/user/models/get_profile_data_model.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../auth/controller/reg_form_controller.dart';
import '../../../home/controllers/home_controller.dart';
import '/app/routes/route.dart' as route;

class UserController extends GetxController {
  File selectedImageMain;
  File selectedImageMain2;
  File selectedImageAddress;
  File selectedImageAddress2;
  File avatar;
  RxBool passLoading = RxBool(false);

  String passDate1;

  clearImages1() {
    selectedImageMain = null;
    // selectedImageMain2.value = null;
    update();
  }

  clearImages2() {
    selectedImageAddress = null;
    // selectedImageAddress2.value = null;
    update();
  }

  clearImages3() {
    selectedImageMain2 = null;
    // selectedImageMain2.value = null;
    update();
  }

  clearImages4() {
    selectedImageAddress2 = null;
    // selectedImageAddress2.value = null;
    update();
  }

  void savePassDate1(val) {
    passDate1 = val.toString().substring(0, 10);
    // print(passDate1);
    update();
  }

  String passDate2;

  void savePassDate2(val) {
    passDate2 = val.toString().substring(0, 10);
    update();
  }

  String passDate3;

  void savePassDate3(val) {
    passDate3 = val.toString().substring(0, 10);
    update();
  }

  void datePicker(context, int num) {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        theme: const DatePickerTheme(
          doneStyle: TextStyle(
            color: Color(
              0xff3C6FE4,
            ),
            fontWeight: FontWeight.w700,
          ),
          cancelStyle: TextStyle(
            color: Color(0xff49536D),
          ),
        ),
        onChanged: null, onConfirm: (date) {
      if (num == 1) {
        savePassDate1(date);
      } else if (num == 2) {
        savePassDate2(date);
      } else if (num == 3) {
        savePassDate3(date);
      }
    }, currentTime: DateTime.now(), locale: LocaleType.ru);
  }

  bool mainRegEdit = false;
  bool passportRegEdit = false;

  final GlobalKey<FormState> formKeyUserSettings = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyUserSettingsPassport =
      GlobalKey<FormState>();

  final maskFormatter1 = MaskTextInputFormatter(mask: '###-###');

  bool checkbox = false;
  RxBool checkbox1 = RxBool(false);

  List<List<String>> positionList = [];
  String savedPosition;

  void savePosition(val) {
    savedPosition = val;
  }

  String firstName;

  void saveFirstName(val) {
    firstName = val;
  }

  String secondName;

  void saveSecondName(val) {
    secondName = val;
  }

  String patranomicName;

  void savepatranomicName(val) {
    patranomicName = val;
  }

  String passportNumber;

  void savePassportNumber(val) {
    passportNumber = val;
  }

  String passportSeries;

  void savePassportSeries(val) {
    passportSeries = val;
  }

  String kemVidan;

  void saveKemVidan(val) {
    kemVidan = val;
  }

  String codeDivision;

  void saveCodeDivision(val) {
    codeDivision = val;
  }

  String birthPlace;

  void saveBirthPlace(val) {
    birthPlace = val;
  }

  String registrationPlace;

  void saveRegistrationPlace(val) {
    registrationPlace = val;
  }

  String inn;

  void saveInn(val) {
    inn = val;
  }

  Future<String> logout() async {
    final result = await ApiSettingUser.logout();
    return result;
  }

  Future logoutMenu(context) async {
    showOkCancelAlertDialog(
            title: 'Сообщение',
            message: 'Выйти из профиля?',
            okLabel: 'Выйти',
            cancelLabel: 'Отмена',
            context: context)
        .then((value) {
      if (value == OkCancelResult.ok) {
        logout().then((value) async {
          if (value == 'success') {
            GetStorage storage = GetStorage();
            storage.remove('CACHEDSPECS');
            storage.remove('showAction');
            storage.remove('countAction');
            Navigator.pop(context);
            await removeImageFromMemory();
            Navigator.pushReplacementNamed(context, route.authScreen);

            storage.write('firstEnter', null);
          } else {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, route.authScreen);
          }
        });
      }
    });
  }

  Future removeImageFromMemory() async {
    try {
      String imagePath = '';
      if (Platform.isAndroid) {
        final appDir = await getExternalStorageDirectory();
        imagePath = '${appDir.path}/Pictures/avatar.png';
      } else {
        final appDir = await getApplicationDocumentsDirectory();
        imagePath = '${appDir.path}/Pictures/avatar.png';
      }
      final file = File(imagePath);
      HomeController homeController = Get.find();
      if (await file.exists()) {
        homeController.avatar.value = null;
        await file.delete();
      }
    } catch (e, s) {
      print(e);
    }
    update();
  }

  Future deleteAccount(context) {
    showOkCancelAlertDialog(
            title: 'Сообщение',
            message: 'Удалить аккаунт?',
            okLabel: 'Да',
            cancelLabel: 'Нет',
            context: context)
        .then((value) {
      if (value == OkCancelResult.ok) {
        Get.delete<RegFormController>(force: true);
        logout().then((value) async {
          if (value == 'success') {
            GetStorage storage = GetStorage();
            storage.remove('CACHEDSPECS');
            Navigator.pop(context);
            await removeImageFromMemory();
            Navigator.pushReplacementNamed(context, route.authScreen);
            storage.write('firstEnter', null);
          } else {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, route.authScreen);
          }
        });
      }
    });
  }

  Future<GetProfileDataModel> getProfileData() async {
    GetProfileDataModel result = await ApiSettingUser.getProfileData();
    return result;
  }

  Future<GetProfileDataModel> putPassportProfileData(files) async {
    GetProfileDataModel result = await ApiSettingUser.postProfileData(
      SendPassportRequestModel(
          passportNumber: passportNumber,
          seriesNumber: passportSeries,
          dateOfIssue: passDate1,
          subdivisionCode: codeDivision,
          issuedBy: kemVidan,
          dateOfBirth: passDate2,
          placeOfBirth: birthPlace,
          dateOfRegistration: passDate3,
          placeOfRegistration: registrationPlace,
          passportData: [files, files],
          // passportFront: '',
          // passportAddress: '',
          name: firstName,
          lastName: secondName,
          patranomic: patranomicName),
    );
    return result;
  }

  void getPhoto() async {
    FilePickerResult result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      selectedImageMain = File(result.files.single.path);
      update();
    } else {
      // CustomSnackBar.badSnackBar(context, 'Выбор фото отменен.');
    }
    update();
  }

  void getPhoto2() async {
    FilePickerResult result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      selectedImageAddress = File(result.files.single.path);
      update();
    } else {
      // CustomSnackBar.badSnackBar(context, 'Выбор фото отменен.');
    }
    update();
  }

  void getPhoto3() async {
    FilePickerResult result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      selectedImageMain2 = File(result.files.single.path);
      update();
    } else {
      // CustomSnackBar.badSnackBar(context, 'Выбор фото отменен.');
    }
    update();
  }

  void getPhoto4() async {
    FilePickerResult result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      selectedImageAddress2 = File(result.files.single.path);
      update();
    } else {
      // CustomSnackBar.badSnackBar(context, 'Выбор фото отменен.');
    }
    update();
  }
}
