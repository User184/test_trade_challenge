import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:teklub/auth/models/promo_check_model.dart';
import 'package:teklub/auth/models/sms_check_model.dart';
import 'package:teklub/auth/models/specs_model.dart';

import '../data/api_service.dart';
import '../models/login_check_models.dart';

class AuthController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPhoneInfo();
  }

  final GlobalKey<FormState> formKey11 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey3 = GlobalKey<FormState>();

  final maskFormatter1 = MaskTextInputFormatter(mask: '7 (###) ###-##-##');
  final maskFormatter2Sms = MaskTextInputFormatter(mask: '#####');

  String platform;
  String osVersion;

  String companyName = 'teklub-challenge';
  String fmcToken;
  String phoneNumber;
  String promoCode = '1705';
  String smsPass;
  List<List<String>> officePositions = [];

  List authFiles = [];
  List<SpecsModel> specs = [];

  updateAuthFiles(List files) {
    authFiles = files;
    update();
  }

  updateSpecFiles(List listSpecs) {
    specs = listSpecs;
    update();
  }

  bool loading = false;

  GetStorage storage = GetStorage();

  saveLoginCheckFormCompanyName(String val) {
    companyName = 'teklub-cashback';
    update();
  }

  saveLoginCheckFormPhoneNumber(String val) {
    phoneNumber = val; //'phone": "79168314863",
    update();
  }

  saveSmsPass(String val) {
    smsPass = val;
    update();
  }

  toggleLoading() {
    loading = !loading;
    update();
  }

  void getPhoneInfo() async {
    AndroidDeviceInfo androidInfo;
    IosDeviceInfo iosInfo;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    FirebaseMessaging.instance.getToken().then((token) {
      fmcToken = token;
    });
    try {
      if (Platform.isAndroid) {
        androidInfo = await deviceInfo.androidInfo;
        osVersion = androidInfo.version.sdkInt.toString();
        platform = 'android';
      }
      if (Platform.isIOS) {
        iosInfo = await deviceInfo.iosInfo;
        osVersion = iosInfo.systemVersion;
        platform = 'ios';
      }
    } catch (e) {}
  }

  Future<LoginAuth> userLoginCheck() async {
    LoginAuth result = await APIServiceAuth.loginCheck(
      LoginRequestModel(
          slug: companyName.toLowerCase(),
          phone: phoneNumber.replaceAll(RegExp(r'[^0-9]'), ''),
          promoCode: promoCode),
    );
    return result;
  }

  Future<PromoAuth> userPromoCheck() async {
    PromoAuth result = await APIServiceAuth.promoCheck(
      PromoRequestModel(
        slug: companyName,
        phone: phoneNumber.replaceAll(RegExp(r'[^0-9]'), ''),
        promoCode: promoCode.trim(),
      ),
    );
    return result;
  }

  Future<SmsAuth> userSmsCheck() async {
    SmsAuth result = await APIServiceAuth.smsCheck(
      SmsRequestModel(
          slug: companyName,
          phone: phoneNumber.replaceAll(RegExp(r'[^0-9]'), ''),
          password: smsPass,
          os: platform,
          version: osVersion,
          deviceToken: fmcToken,
          promoCode: promoCode),
    );
    return result;
  }
}
