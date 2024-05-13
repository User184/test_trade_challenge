import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:teklub/scanner/models/mechanic_model.dart';
import 'package:teklub/scanner/models/scan_models.dart';

class ApiScanService {
  static Future<ScanModel> scanChecks(ScanRequestModel requestModel) async {
    print(requestModel.toJson());
    GetStorage storage = GetStorage();
    String token = await storage.read('token');
    Map<String, String> headers = {
      "Accept": "application/json; charset=UTF-8",
      'Authorization': 'Bearer $token',
    };
    String url = "${storage.read('domen')}user-checks";

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
      if (response.statusCode == 201) {
        return SuccessRequestScan(success: 'true');
      } else if (json.decode(response.body)['code'] == 300) {
        return SuccessRequestScan(success: 'false');
      } else {
        return ErrorRequestScan(
            error: json.decode(utf8.decode(response.bodyBytes)).toString());
      }
    } on HttpException {
      return ErrorRequestScan(error: 'Ошибка запроса.');
    } on SocketException {
      return ErrorRequestScan(error: 'Нет соединения с сервером.');
    }
  }

  static Future<MechanicModel> getMechanic() async {
    GetStorage storage = GetStorage();
    String token = await storage.read('token');
    String domen = await storage.read('domen');

    String url = "${domen}mechanics";

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
      // print(response.statusCode);
      // print(json
      //     .decode(
      //   utf8.decode(response.bodyBytes),
      // )
      //     .toString());

      if (response.statusCode == 200) {
        return mechanicModelFromJson(response.body);
      } else {
        return ErrorRequestMechanic(
            error: json
                .decode(
                  utf8.decode(response.bodyBytes),
                )
                .toString());
      }
    } on HttpException {
      return ErrorRequestMechanic(error: 'Ошибка запроса.');
    } on SocketException {
      return ErrorRequestMechanic(error: 'Нет соединения с сервером.');
    }
  }
}
