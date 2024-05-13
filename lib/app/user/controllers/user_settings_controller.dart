import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:get/get.dart';


class UserSettingsController extends GetxController {

  final GlobalKey<FormState> formKeyUserSettings = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyUserSettingsPassport = GlobalKey<FormState>();

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

  String patranomic;
  void savePatranomic(val) {
    patranomic = val;
  }

  String phone;
  void savePhone(val) {
    phone = val;
  }

  String email;
  void saveEmail(val) {
    email = val;
  }

  String inn;
  void saveInn(val) {
    inn = val;
  }

  List storeNameList = [];
  String storeName;

  void saveStoreName(val) {
    storeName = val;
  }

  List cityList = [];
  String city;

  void saveCity(val) {
    city = val;
  }

  List addressStoreList = [];
  String addressStore;

  void saveAddressStore(val) {
    addressStore = val;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
