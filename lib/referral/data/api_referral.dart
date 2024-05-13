import 'dart:convert';
import 'dart:io';
// import 'package:alice/alice.dart';
// import 'package:alice/core/alice_http_extensions.dart';
import 'package:get_storage/get_storage.dart';
import '../../main.dart';
import '../models/CashbackModel.dart';
import 'package:http/http.dart' as http;

import '../models/my_referral_model.dart';

class ApiReferral {
  static Future<AbsCashbackModel> getCashback() async {
    GetStorage storage = GetStorage();
    String url = "${storage.read('domen')}detail";
    String token = await storage.read('token');
    print(token);
    Map<String, String> headers = {
      "Accept": "application/json",
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await http
          .get(Uri.parse(url), headers: headers)
          ;
      print('MMMMMMMM${json.decode(response.body)}');
      print(url);

      //alice.onHttpResponse(response);

      if (response.statusCode == 200) {
        return CashbackModel.fromJson(
          json.decode(response.body),
        );
      } else if (json.decode(response.body)['code'] == 451) {
        return ErrorRequestCashback(error: 'Нет активных акций.');
      } else {
        return ErrorRequestCashback(error: 'Данные не найдены.');
      }
    } on HttpException {
      return ErrorRequestCashback(error: 'Ошибка запроса.');
    } on SocketException {
      return ErrorRequestCashback(error: 'Нет соединения с сервером.');
    }
  }

  static Future<AbsMyReferralModel> getMyReferral() async {
    GetStorage storage = GetStorage();
    String url = "${storage.read('domen')}referrals/my";
    String token = await storage.read('token');
    Map<String, String> headers = {
      "Accept": "application/json",
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await http
          .get(Uri.parse(url), headers: headers)
          ;
      //print(response.body);
      //print(response.statusCode);
      //print('MMMMMMMM${json.decode(response.body)}');
      print(
          'XXXXXX${MyReferralModel.fromJson(json.decode(utf8.decode(response.bodyBytes)))}');

      if (response.statusCode == 200) {
        return MyReferralModel.fromJson(
          json.decode(response.body),
        );
      } else if (json.decode(response.body)['code'] == 451) {
        return ErrorRequestMyReferral(error: 'Нет активных акций.');
      } else {
        return ErrorRequestMyReferral(error: 'Данные не найдены.');
      }
    } on HttpException {
      return ErrorRequestMyReferral(error: 'Ошибка запроса.');
    } on SocketException {
      return ErrorRequestMyReferral(error: 'Нет соединения с сервером.');
    }
  }
}
