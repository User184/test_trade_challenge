import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../models/actions_model.dart';

class ApiServiceAction {
  static Future<ActionsModelAbs> getAction() async {
    GetStorage storage = GetStorage();
    String url = "${storage.read('domen')}conditions";

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
      // print(url);
      // print(token);

      log('<<<<<conditionsconditions${json.decode(utf8.decode(response.bodyBytes))}');
      if (response.statusCode == 200) {
        return ActionsModel.fromJson(json.decode(response.body));
      } else {
        return ErrorRequestAction(
            error: json
                .decode(utf8.decode(response.bodyBytes))['massage']
                .toString());
      }
    } on HttpException {
      return ErrorRequestAction(error: 'Ошибка запроса.');
    } on SocketException {
      return ErrorRequestAction(error: 'Нет соединения с сервером.');
    }
  }
}
