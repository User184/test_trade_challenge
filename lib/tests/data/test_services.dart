import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:teklub/tests/controllers/test_controller.dart';
import 'package:teklub/tests/models/new_test.dart';
import 'package:teklub/tests/models/test_send_model.dart';

import '../models/test_model.dart';

class ApiServiceTest {
  static Future<TestModel> getTests() async {
    GetStorage storage = GetStorage();
    String url = "${storage.read('domen')}tests";
    String token = await storage.read('token');

    Map<String, String> headers = {
      "Accept": "application/json; charset=UTF-8",
      'content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      print(url);
      // print(response.statusCode);
      // print(json
      //     .decode(
      //       utf8.decode(response.bodyBytes),
      //     )
      //     .toString());

      if (response.statusCode == 200) {
        return testModelFromJson(response.body);
      } else {
        return ErrorRequestTests(
            error: json
                .decode(
                  utf8.decode(response.bodyBytes),
                )
                .toString());
      }
    } on HttpException {
      return ErrorRequestTests(error: 'Ошибка запроса.');
    } on SocketException {
      return ErrorRequestTests(error: 'Нет соединения с сервером.');
    }
  }

  static Future<NewTest> getNewTest(int testId) async {
    GetStorage storage = GetStorage();
    String url = "${storage.read('domen')}tests/$testId";
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
      // print(response.statusCode);
      // print(json
      //     .decode(
      //       utf8.decode(response.bodyBytes),
      //     )
      //     .toString());

      if (response.statusCode == 200) {
        return newTestFromJson(response.body);
      } else {
        return ErrorRequestNewTest(
            error: json
                .decode(
                  utf8.decode(response.bodyBytes),
                )
                .toString());
      }
    } on HttpException {
      return ErrorRequestNewTest(error: 'Ошибка запроса.');
    } on SocketException {
      return ErrorRequestNewTest(error: 'Нет соединения с сервером.');
    }
  }

  static Future<TestSend> sendTest() async {
    GetStorage storage = GetStorage();
    TestController testController = Get.find();
    String url =
        "${storage.read('domen')}tests/${testController.newTest.value.data.id}/passing";

    String token = await storage.read('token');
    Map<String, String> headers = {
      "Accept": "application/json; charset=UTF-8",
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      Map<String, dynamic> toJson() {
        Map<String, dynamic> map = {
          'questions': [...testController.progressTestList],
        };
        return map;
      }

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(toJson()),
      );

      print(url);
      print(response.statusCode);
      print(json
          .decode(
            utf8.decode(response.bodyBytes),
          )
          .toString());

      if (response.statusCode == 200) {
        return testSendFromJson(
          response.body,
        );
      } else {
        return ErrorRequestTestSend(error: 'Данные не найдены.');
      }
    } on HttpException {
      return ErrorRequestTestSend(error: 'Ошибка запроса.');
    } on SocketException {
      return ErrorRequestTestSend(error: 'Нет соединения с сервером.');
    }
  }
}
