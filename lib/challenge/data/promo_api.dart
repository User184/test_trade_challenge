import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/api_file_get_model.dart';
import '../models/promo_model.dart';

class ApiPromo {
  static Future<PromoModel> getPromoData() async {
    GetStorage storage = GetStorage();
    String token = await storage.read('token');
    String domen = await storage.read('domen');

    String url = "${domen}detail";

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
      // print(response.statusCode);
      // print(json
      //     .decode(
      //       utf8.decode(response.bodyBytes),
      //     )
      //     .toString());

      if (response.statusCode == 200) {
        return promoModelFromJson(response.body);
      } else {
        return ErrorPromoDetail(json
            .decode(
              utf8.decode(response.bodyBytes),
            )
            .toString());
      }
    } on HttpException {
      return ErrorPromoDetail('Ошибка запроса.');
    } on SocketException {
      return ErrorPromoDetail('Нет соединения с сервером.');
    }
  }

  static Future<ApiFileGetModel> getPromoFiles(String withdrawalId) async {
    GetStorage storage = GetStorage();
    String token = await storage.read('token');
    String domen = await storage.read('domen');

    String url = "${domen}user-withdrawals/$withdrawalId/acts/download";

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
      // print(response.statusCode);
      // print(json
      //     .decode(
      //       utf8.decode(response.bodyBytes),
      //     )
      //     .toString());

      if (response.statusCode == 200) {
        return apiFileGetModelFromJson(response.body);
      } else {
        return ErrorGetFile(json
            .decode(
              utf8.decode(response.bodyBytes),
            )
            .toString());
      }
    } on HttpException {
      return ErrorGetFile('Ошибка запроса.');
    } on SocketException {
      return ErrorGetFile('Нет соединения с сервером.');
    }
  }

  static Future sendEmail(String withdrawalId) async {
    GetStorage storage = GetStorage();
    String token = await storage.read('token');
    String domen = await storage.read('domen');

    String url = "${domen}user-withdrawals/$withdrawalId/acts/send";

    Map<String, String> headers = {
      "Accept": "application/json; charset=UTF-8",
      // 'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: {},
      );

      print(token);
      print(response.statusCode);
      print(json
          .decode(
            utf8.decode(response.bodyBytes),
          )
          .toString());

      if (response.statusCode == 201) {
        return 'ok';
      } else {
        return 'error';
      }
    } on HttpException {
      return 'Ошибка запроса.';
    } on SocketException {
      return 'Нет соединения с сервером.';
    }
  }

  static Future<String> postAct(String withdrawalId, List<File> docs) async {
    GetStorage storage = GetStorage();
    String token = await storage.read('token');
    String domen = await storage.read('domen');

    String url = "${domen}user-withdrawals/$withdrawalId/acts/add";

    Map<String, String> headers = {
      "Accept": "application/json; charset=UTF-8",
      'Authorization': 'Bearer $token',
    };

    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));
      request.headers.addAll(headers);
      request.fields.addAll({
        '_method': 'put',
      });

      docs.forEach((element) async {
        request.files.add(
          await http.MultipartFile.fromPath('acts[]', element.path),
        );
      });

      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      print(url);
      print(response.statusCode);
      // print(json
      //     .decode(
      //       utf8.decode(await response.stream.toBytes()),
      //     )
      //     .toString());

      if (response.statusCode == 204) {
        return 'ok';
      } else {
        return 'err';
      }
    } on HttpException {
      return 'err';
    } on SocketException {
      return 'err';
    }
  }
}
