import 'dart:convert';
import 'dart:io';

//import 'package:alice/alice.dart';
//import 'package:alice/core/alice_http_extensions.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:teklub/app/user/controllers/user_controller.dart';
import 'package:teklub/app/user/models/get_profile_data_model.dart';
import 'package:teklub/app/user/models/pass_model.dart';

import '../../../auth/models/wlk_screen_model.dart';

class ApiSettingUser {
  static Future<String> logout() async {
    GetStorage storage = GetStorage();
    String domen = await storage.read('domen');
    String token = await storage.read('token');
    String url = "${domen}auth/logout";

    Map<String, String> headers = {
      "Accept": "application/json; charset=UTF-8",
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
      );
      if (response.statusCode == 200) {
        return 'success';
      } else {
        return 'Error';
      }
    } on HttpException {
      return 'Ошибка запроса.';
    } on SocketException {
      return 'Нет соединения с сервером.';
    }
  }

  static Future<GetProfileDataModel> getProfileData() async {
    GetStorage storage = GetStorage();
    String token = await storage.read('token');
    String domen = await storage.read('domen');

    String url = "${domen}user/profile";

    Map<String, String> headers = {
      "Accept": "application/json; charset=UTF-8",
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      print(url);
      print(token);
      print(response.statusCode);
      print(json
          .decode(
            utf8.decode(response.bodyBytes),
          )
          .toString());

      if (response.statusCode == 200) {
        return getProfileDataModelFromJson(response.body);
      } else {
        return ErrorRequestProfileData(
            error: json
                .decode(
                  utf8.decode(response.bodyBytes),
                )
                .toString());
      }
    } on HttpException {
      return ErrorRequestProfileData(error: 'Ошибка запроса.');
    } on SocketException {
      return ErrorRequestProfileData(error: 'Нет соединения с сервером.');
    }
  }

  static Future<GetProfileDataModel> postProfileData(
      SendPassportRequestModel passportRequest) async {
    // print(passportRequest.toJson());
    print('DDDD${passportRequest.toJson()}');
    print('DDFFFFDD${passportRequest.passportData[0].path}');
    GetStorage storage = GetStorage();
    String token = await storage.read('token');
    String domen = await storage.read('domen');

    String url = "${domen}user/passport-data";

    Map<String, String> headers = {
      "Accept": "application/json; charset=UTF-8",
      'Authorization': 'Bearer $token',
    };

    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));
      request.headers.addAll(headers);

      request.fields.addAll({
        '_method': 'put',
        'series_number': passportRequest.seriesNumber,
        'passport_number': passportRequest.passportNumber,
        'date_of_issue': passportRequest.dateOfIssue,
        'subdivision_code': passportRequest.subdivisionCode,
        'issued_by': passportRequest.issuedBy,
        'date_of_birth': passportRequest.dateOfBirth,
        'place_of_birth': passportRequest.placeOfBirth,
        'date_of_registration': passportRequest.dateOfRegistration,
        'place_of_registration': passportRequest.placeOfRegistration,
        // 'inn': passportRequest.inn,
      });

      if (passportRequest.passportData[0] != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'passport_front[]', '${passportRequest.passportData[0].path}'));
      }

      if (passportRequest.passportData[1] != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'passport_address[]', '${passportRequest.passportData[1].path}'));
      }

      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      print('passport');

      print(response.request);

      print(url);
      print("passport${response.statusCode}");
      // print(json
      //     .decode(
      //       utf8.decode(await response.stream.toBytes()),
      //     )
      //     .toString());
      print('passport1');

      if (response.statusCode == 204) {
        return Success('ok');
      } else if (response.statusCode == 422) {
        return ErrorMsg('Ошибка ввода данных');
      }
      {
        return ErrorMsg('Попробуйте позже');
      }
    } on HttpException {
      UserController userController = Get.find();

      userController.passLoading.value = true;
      return ErrorRequestProfileData(error: 'Ошибка запроса.');
    } on SocketException {
      return ErrorRequestProfileData(error: 'Нет соединения с сервером.');
    }
  }

  static Future<GetProfileDataModel> deletePhotosPassport(String pra) async {
    GetStorage storage = GetStorage();
    String token = await storage.read('token');
    String domen = await storage.read('domen');

    String url = "${domen}user/passport-data";

    Map<String, String> headers = {
      "Accept": "application/json; charset=UTF-8",
      'Authorization': 'Bearer $token',
    };

    try {
      print(pra);
      final response = await http.post(Uri.parse(url),
          headers: headers, body: {'_method': 'put', pra: ''});
      print(response.statusCode);
      if (response.statusCode == 204) {
        return Success('ok');
      } else if (response.statusCode == 422) {
        return ErrorMsg('Ошибка ввода данных');
      }
      {
        return ErrorMsg('Попробуйте позже');
      }
    } on HttpException {
      UserController userController = Get.find();

      userController.passLoading.value = true;
      return ErrorRequestProfileData(error: 'Ошибка запроса.');
    } on SocketException {
      return ErrorRequestProfileData(error: 'Нет соединения с сервером.');
    }
  }

  static Future<PassModel> getPassportData() async {
    GetStorage storage = GetStorage();
    String token = await storage.read('token');
    String domen = await storage.read('domen');

    print(domen);

    String url = "${domen}user/passport-data";

    Map<String, String> headers = {
      "Accept": "application/json; charset=UTF-8",
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      // print(url);
      // print(json
      //     .decode(
      //       utf8.decode(response.bodyBytes),
      //     )
      //     .toString());

      if (response.statusCode == 200) {
        return passModelFromJson(response.body);
      } else {
        return ErrorPass(json
            .decode(
              utf8.decode(response.bodyBytes),
            )
            .toString());
      }
    } on HttpException {
      return ErrorPass('Ошибка запроса.');
    } on SocketException {
      return ErrorPass('Нет соединения с сервером.');
    }
  }

  static Future setInn(String inn, String name, String lName) async {
    GetStorage storage = GetStorage();
    String token = await storage.read('token');
    String domen = await storage.read('domen');

    String url = "${domen}user/profile";

    try {
      Map<String, String> headers = {
        "Accept": "application/json; charset=UTF-8",
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      Map<String, dynamic> jsonData;

      if (name == null && lName == null) {
        jsonData = {
          "inn": inn,
        };
      } else {
        jsonData = {"inn": inn, "name": name, "last_name": lName};
      }

      final response = await http.put(
        Uri.parse(url),
        body: const JsonEncoder().convert(jsonData),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return 'OK';
      } else if (response.statusCode == 400) {
        return 'ERR';
      } else {
        return '{ERR2}';
      }
    } on HttpException {
      return 'Ошибка запроса.';
    } on SocketException {
      return 'Нет соединения с сервером.';
    }
  }

  static Future<String> setCity(String city) async {
    GetStorage storage = GetStorage();
    String token = await storage.read('token');
    String domen = await storage.read('domen');

    String url =
        "https://knauf.pryanik.12.digital/api/v2/cities/get-region-by-city/";

    Map<String, String> headers = {
      "Accept": "application/json; charset=UTF-8",
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      Map<String, dynamic> jsonData;
      jsonData = {"city": city};

      final response = await http.post(
        Uri.parse(url),
        body: const JsonEncoder().convert(jsonData),
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
        return response.body;
      } else {
        return 'Город не найден';
      }
    } on HttpException {
      return 'Ошибка запроса.';
    } on SocketException {
      return 'Нет соединения с сервером.';
    }
  }

  static Future setMail(String mail) async {
    GetStorage storage = GetStorage();
    String token = await storage.read('token');
    String domen = await storage.read('domen');

    String url = "${domen}user/profile";

    try {
      Map<String, String> headers = {
        "Accept": "application/json; charset=UTF-8",
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      Map<String, dynamic> jsonData;

      jsonData = {"email": mail};

      final response = await http.put(
        Uri.parse(url),
        body: const JsonEncoder().convert(jsonData),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return 'OK';
      } else if (response.statusCode == 400) {
        return 'ERR';
      } else {
        return '{ERR2}';
      }
    } on HttpException {
      return 'Ошибка запроса.';
    } on SocketException {
      return 'Нет соединения с сервером.';
    }
  }

  static Future setSpecs(List specs) async {
    GetStorage storage = GetStorage();
    String token = await storage.read('token');
    String domen = await storage.read('domen');

    String url = "${domen}user/profile";

    print(specs);
    try {
      Map<String, String> headers = {
        "Accept": "application/json; charset=UTF-8",
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      Map<String, dynamic> jsonData;

      jsonData = {"specializations": specs};

      final response = await http.put(
        Uri.parse(url),
        body: const JsonEncoder().convert(jsonData),
        headers: headers,
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        return 'OK';
      } else if (response.statusCode == 204) {
        return 'OK';
      } else if (response.statusCode == 400) {
        return 'ERR';
      } else {
        return '{ERR2}';
      }
    } on HttpException {
      return 'Ошибка запроса.';
    } on SocketException {
      return 'Нет соединения с сервером.';
    }
  }

  static Future<WlkScreen> checkWelcomeScreens(bool isLogin) async {
    GetStorage storage = GetStorage();
    String token = await storage.read('token');
    String domen = await storage.read('domen');

    String url = "${domen}welcome-screens?force=$isLogin";

    print(url);
    try {
      Map<String, String> headers = {
        "Accept": "application/json; charset=UTF-8",
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      print(json
          .decode(
            utf8.decode(response.bodyBytes),
          )
          .toString());

      if (response.statusCode == 200) {
        return WlkScreen.fromJson(json.decode(response.body));
      } else if (response.statusCode == 204) {
        return WlkScreen.fromJson(json.decode(response.body));
      }
    } on HttpException {
      return ErrorWlkScreen(error: 'Ошибка запроса.');
    } on SocketException {
      return ErrorWlkScreen(error: 'Нет соединения с сервером.');
    }
  }

  static Future setSpecsAndPromoCode(List specs, {bool isInn = false}) async {
    GetStorage storage = GetStorage();
    String token = await storage.read('token');
    String domen = await storage.read('domen');

    String url = "${domen}user/profile";

    print(specs);
    try {
      Map<String, String> headers = {
        "Accept": "application/json; charset=UTF-8",
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      Map<String, dynamic> jsonData;

      jsonData = isInn
          ? {
              "inn": specs[0],
            }
          : {
              "specializations": specs,
            };

      final response = await http.put(
        Uri.parse(url),
        body: const JsonEncoder().convert(jsonData),
        headers: headers,
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        return 'OK';
      } else if (response.statusCode == 204) {
        return 'OK';
      } else if (response.statusCode == 400) {
        return 'ERR';
      } else {
        return '{ERR2}';
      }
    } on HttpException {
      return 'Ошибка запроса.';
    } on SocketException {
      return 'Нет соединения с сервером.';
    }
  }

  static Future<String> setEnter() async {
    print('!!!!!!!!!!!!!!!!');
    GetStorage storage = GetStorage();
    String token = await storage.read('token');
    String domen = await storage.read('domen');

    print(domen);
    String url = "${domen}auth/me/visit";

    Map<String, String> headers = {
      "Accept": "application/json; charset=UTF-8",
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      Map<String, dynamic> jsonData;
      jsonData = {};

      final response = await http.post(
        Uri.parse(url),
        body: const JsonEncoder().convert(jsonData),
        headers: headers,
      );
      print('=======$response');
      print('0000$url');
      print(response.statusCode);

      print(json
          .decode(
            utf8.decode(response.bodyBytes),
          )
          .toString());

      if (response.statusCode == 200) {
        print('!!!!');
        return response.body;
      } else {
        return 'Ошибка';
      }
    } on HttpException {
      return 'Ошибка запроса.';
    } on SocketException {
      return 'Нет соединения с сервером.';
    }
  }
}
