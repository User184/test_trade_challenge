import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:teklub/auth/models/get_files_models.dart';
import 'package:teklub/auth/models/permission_model4.dart';
import 'package:teklub/auth/models/wlk_screen_model.dart';

class ApiSetting {
  static Future<GetFilesModels> filesGet() async {
    GetStorage storage = GetStorage();
    String token = await storage.read('token');
    String domen = await storage.read('domen');

    String url = "${domen}files";

    print(url);

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

      // print(json
      //     .decode(
      //       utf8.decode(response.bodyBytes),
      //     )
      //     .toString());

      if (response.statusCode == 200) {
        return getFilesModelsFromJson(response.body);
      } else {
        return ErrorRequestGetFiles(
            error: json
                .decode(
                  utf8.decode(response.bodyBytes),
                )
                .toString());
      }
    } on HttpException {
      return ErrorRequestGetFiles(error: 'Ошибка запроса.');
    } on SocketException {
      return ErrorRequestGetFiles(error: 'Нет соединения с сервером.');
    }
  }

  static Future<PermissionModel4> getPermissions() async {
    GetStorage storage = GetStorage();

    String url = "${storage.read('domen')}auth/me";
    String token = await storage.read('token');
    Map<String, String> headers = {
      "Accept": "application/json; charset=UTF-8",
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      print('object');
      final response = await http.get(
        Uri.parse(url),
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
        return permissionModel4FromJson(response.body);
      } else {
        return ErrorRequestPermission4(
            error: json
                .decode(
                  utf8.decode(response.bodyBytes),
                )
                .toString());
      }
    } on HttpException {
      return ErrorRequestPermission4(error: 'Ошибка запроса.');
    } on SocketException {
      return ErrorRequestPermission4(error: 'Нет соединения с сервером.');
    }
  }

  static Future<WlkScreen> getWelcomeScreens() async {
    GetStorage storage = GetStorage();
    final domen = storage.read('domen');

    String url = "${domen}welcome-screens";

    String token = await storage.read('token');

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
      print(response.statusCode);
      print(json
          .decode(
            utf8.decode(response.bodyBytes),
          )
          .toString());

      if (response.statusCode == 200) {
        return wlkScreenFromJson(response.body);
      } else {
        return ErrorWlkScreen(
            error: json
                .decode(
                  utf8.decode(response.bodyBytes),
                )
                .toString());
      }
    } on HttpException {
      return ErrorWlkScreen(error: 'Ошибка запроса.');
    } on SocketException {
      return ErrorWlkScreen(error: 'Нет соединения с сервером.');
    }
  }

  static Future<GetFilesModels> filesGetRegScreen() async {
    GetStorage storage = GetStorage();
    String domen = await storage.read('domen');

    String url = "${domen}files";

    // print(url);

    Map<String, String> headers = {
      "Accept": "application/json; charset=UTF-8",
      'Content-Type': 'application/json',
    };
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      // print(json
      //     .decode(
      //   utf8.decode(response.bodyBytes),
      // )
      //     .toString());

      if (response.statusCode == 200) {
        return getFilesModelsFromJson(response.body);
      } else {
        return ErrorRequestGetFiles(
            error: json
                .decode(
                  utf8.decode(response.bodyBytes),
                )
                .toString());
      }
    } on HttpException {
      return ErrorRequestGetFiles(error: 'Ошибка запроса.');
    } on SocketException {
      return ErrorRequestGetFiles(error: 'Нет соединения с сервером.');
    }
  }
}
