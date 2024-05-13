import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:teklub/home/notofiaction/models/msg_model.dart';

class ApiServiceNotification {
  static Future<MsgModel> filesNotification() async {
    GetStorage storage = GetStorage();
    String url = "${storage.read('domen')}notifications?paginate=20&page=1";
    String token = await storage.read('token');
    print('urlurlurlvurl${url}');
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
        return msgModelFromJson(response.body);
      } else {
        return throw ErrorRequestMsg(error: 'Error');
      }
    } on HttpException {
      return ErrorRequestMsg(error: 'Ошибка запроса.');
    } on SocketException {
      return ErrorRequestMsg(error: 'Нет соединения с сервером.');
    }
  }

  static Future<MsgModel> readStatus() async {
    GetStorage storage = GetStorage();
    String url = "${storage.read('domen')}notifications/read";
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
      print(json
          .decode(
            utf8.decode(response.bodyBytes),
          )
          .toString());

      if (response.statusCode == 200) {
        return SuccessMsg(result: 'ok');
      } else {
        return ErrorRequestMsg(error: 'Error');
      }
    } on HttpException {
      return ErrorRequestMsg(error: 'Ошибка запроса.');
    } on SocketException {
      return ErrorRequestMsg(error: 'Нет соединения с сервером.');
    }
  }
}
