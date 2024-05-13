import 'dart:convert';
import 'dart:io';

//import 'package:alice/alice.dart';
//import 'package:alice/core/alice_http_extensions.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:teklub/auth/controller/auth_controller.dart';
import 'package:teklub/auth/models/login_check_models.dart';
import 'package:teklub/auth/models/promo_check_model.dart';
import 'package:teklub/auth/models/register_model.dart';
import 'package:teklub/auth/models/sms_check_model.dart';
import 'package:teklub/auth/models/success_register_model.dart';
import '../models/specs_model.dart';

String urlAdmin = "https://pryanik.12.digital/api/v2/";
String urlDemo = "https://admin.pryanik.online/api/v2/";

bool demo = true;

class APIServiceAuth {
  static Future<LoginAuth> loginCheck(LoginRequestModel requestModel) async {
    String url = "${demo == true ? urlDemo : urlAdmin}auth/send-password";
    print(url);

    try {
      final response = await http.post(
        Uri.parse(url),
        body: requestModel.toJson(),
      );
      print(response.statusCode);
      print(url);

      if (response.statusCode == 200) {
        return LoginResponseModel.fromJson(
          json.decode(response.body),
        );
      } else if (json.decode(response.body).contains('code') &&
          json.decode(response.body)['code'] == 451) {
        return ErrorRequestLogin(error: 'Нет активных акций.');
      } else {
        return ErrorRequestLogin(error: 'Данные не найдены.');
      }
    } on HttpException {
      return ErrorRequestLogin(error: 'Ошибка запроса.');
    } on SocketException {
      return ErrorRequestLogin(error: 'Нет соединения с сервером.');
    }
  }

  static Future<PromoAuth> promoCheck(PromoRequestModel requestModel) async {
    print(requestModel.toJson());

    String url = "${demo == true ? urlDemo : urlAdmin}auth/sign-in";
    print(requestModel.toJson());
    print(url);
    try {
      final response = await http.post(
        Uri.parse(url),
        body: requestModel.toJson(),
      );

      print(response.statusCode);
      print(json
          .decode(
            utf8.decode(response.bodyBytes),
          )
          .toString());

      if (response.statusCode == 200) {
        return PromoResponseModel.fromJson(
          json.decode(response.body),
        );
      } else if (response.statusCode == 400) {
        return ErrorRequestPromo(error: 'Код акции не найден.');
      } else {
        return ErrorRequestPromo(error: 'Ошибка запроса.');
      }
    } on HttpException {
      return ErrorRequestPromo(error: 'Ошибка запроса.');
    } on SocketException {
      return ErrorRequestPromo(error: 'Нет соединения с сервером.');
    }
  }

  static Future<SmsAuth> smsCheck(SmsRequestModel requestModel) async {
    // print(requestModel.toJson());
    String url = "${demo == true ? urlDemo : urlAdmin}auth/sign-in";
    print(requestModel.toJson());
    print(url);
    Map<String, String> headers = {
      "Accept": "application/json; charset=UTF-8",
    };

    print(requestModel.toJson());

    try {
      final response = await http.post(
        Uri.parse(url),
        body: requestModel.toJson(),
        headers: headers,
      );
      print(response.statusCode);
      print(json
          .decode(
            utf8.decode(response.bodyBytes),
          )
          .toString());
      if (response.statusCode == 200) {
        return json.decode(response.body)['code'] == 252
            ? SmsResponseModelReg.fromJson(
                json.decode(response.body),
              )
            : SmsResponseModel.fromJson(
                json.decode(response.body),
              );
      } else if (response.statusCode == 400) {
        return ErrorRequestSms(
          error: 'Неверный SMS код.',
          code: json.decode(response.body)['code'],
        );
      } else {
        return ErrorRequestSms(error: 'Ошибка запроса.');
      }
    } on HttpException {
      return ErrorRequestSms(error: 'Ошибка запроса.');
    } on SocketException {
      return ErrorRequestSms(error: 'Нет соединения с сервером.');
    }
  }

  static Future<RegisterAuth> regFormCheck(
      RegisterRequestModel requestModel) async {
    String url = "${demo == true ? urlDemo : urlAdmin}auth/registration";
    print(url);
    print(requestModel.toJson());

    try {
      Map<String, String> headers = {
        "Accept": "application/json; charset=UTF-8",
      };
      final response = await http.post(
        Uri.parse(url),
        body: requestModel.toJson(),
        headers: headers,
      );

      print(url);
      print(response.statusCode);
      print(json
          .decode(
            utf8.decode(response.bodyBytes),
          )
          .toString());

      if (response.statusCode == 200) {
        return RegisterResponseModel.fromJson(
            json.decode(utf8.decode(response.bodyBytes)));
      } else if (json.decode(response.body)['code'] == 256) {
        return ErrorRequestRegister(
          error: 'Торговая точка не найдена или не участвует в акции.',
        );
      } else if (response.statusCode == 400) {
        return ErrorRequestRegister(
          error: 'Ошибка регистрации.',
        );
      } else {
        return ErrorRequestRegister(
            error: json.decode(utf8.decode(response.bodyBytes)).toString());
      }
    } on HttpException {
      return ErrorRequestRegister(error: 'Ошибка запроса.');
    } on SocketException {
      return ErrorRequestRegister(error: 'Нет соединения с сервером.');
    }
  }

  static Future<RegisterAuth> successRegFormCheck(
      SuccessRegisterRequestModel requestModel) async {
    String url = "${demo == true ? urlDemo : urlAdmin}auth/registration";
    try {
      print('REGION--${requestModel.regionId is int}');
      Map<String, String> headers = {
        "Accept": "application/json; charset=UTF-8",
      };
      final response = await http.post(
        Uri.parse(url),
        body: requestModel.toJson(),
        headers: headers,
      );

      print(url);
      print(requestModel.toJson());
      print(response.statusCode);
      print('bodyyyy${json.decode(response.body)}');
      // json.decode(response.body)['code'] == 252
      if (response.statusCode == 200) {
        return SuccessRegisterResponseModel.fromJson(
            json.decode(utf8.decode(response.bodyBytes)));
      } else if (response.statusCode == 400) {
        return ErrorRequestRegisterSuccess.fromJson(
            json.decode(utf8.decode(response.bodyBytes)));
      } else {
        return ErrorRequestRegisterSuccess.fromJson(
            json.decode(utf8.decode(response.bodyBytes)));
      }
    } on HttpException {
      return ErrorRequestRegister(error: 'Ошибка запроса.');
    } on SocketException {
      return ErrorRequestRegister(error: 'Нет соединения с сервером.');
    }
  }

  static Future<String> updateFcmToken(String fcmToken) async {
    AuthController controller = Get.put(AuthController());
    controller.getPhoneInfo();

    GetStorage storage = GetStorage();
    String url = "${storage.read('domen')}auth/set-fcm-token";

    String token = await storage.read('token');
    Map<String, String> headers = {
      "Accept": "application/json; charset=UTF-8",
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: headers,
        body: {
          'device_token': fcmToken,
          'os': controller.osVersion,
          'version': controller.platform,
        },
      );
      // print(response.statusCode);
      // print(response.body);
      // print(url);
      if (response.statusCode == 200) {
        return 'ok';
      } else {
        return 'bad';
      }
    } on HttpException {
      return 'bad';
    } on SocketException {
      return 'bad';
    }
  }

  static Future<DataSpecsModel> getSpecial() async {
    GetStorage storage = GetStorage();
    String url = "${storage.read('domen')}specialization_segments";

    String token = await storage.read('token');

    Map<String, String> headers = {
      "Accept": "application/json",
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      print('<<<<<${json.decode(utf8.decode(response.bodyBytes))}');
      print(response.statusCode);
      if (response.statusCode == 200) {
        return DataSpecs.fromJson(
          json.decode(utf8.decode(response.bodyBytes)),
        );
      } else {
        return ErrorRequestSpecs(
            error: json
                .decode(utf8.decode(response.bodyBytes))['massage']
                .toString());
      }
    } on HttpException {
      return ErrorRequestSpecs(error: 'Ошибка запроса.');
    } on SocketException {
      return ErrorRequestSpecs(error: 'Нет соединения с сервером.');
    }
  }

  static Future<String> checkVersionApp(String platform) async {
    GetStorage storage = GetStorage();

    String url = "${storage.read('domen')}auth/app?version=$platform";
    print(url);

    String token = await storage.read('token');
    // print(token);
    Map<String, String> headers = {
      "Accept": "application/json; charset=UTF-8",
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      var result;
      print('<<<<<${json.decode(utf8.decode(response.bodyBytes))}');

      if (response.statusCode == 200) {
        print(response); //{"app_version": "2.2.2"}
        try {
          result = json.decode(response.body)['app_version'];
          return result;
        } catch (e) {
          return '';
        }
      } else {
        return '';
      }
    } on HttpException {
      rethrow;
    } on SocketException {
      rethrow;
    }
  }

  static Future<String> sendVersionApp(String appVer, String fcm) async {
    GetStorage storage = GetStorage();

    String url = "${storage.read('domen')}auth/set-fcm-token";
    print(url);

    String token = await storage.read('token');
    print(token);
    Map<String, String> headers = {
      "Accept": "application/json; charset=UTF-8",
      // 'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await http.put(Uri.parse(url), headers: headers, body: {
        "device_token": fcm,
        "app_ver": appVer,
      });
      var result;
      print('<<<<<${json.decode(utf8.decode(response.bodyBytes))}');

      if (response.statusCode == 200) {
        //{"app_version": "2.2.2"}
        try {
          result = json.decode(response.body)['app_version'];
          return result;
        } catch (e) {
          return '';
        }
      } else {
        return '';
      }
    } on HttpException {
      rethrow;
    } on SocketException {
      rethrow;
    }
  }
}
