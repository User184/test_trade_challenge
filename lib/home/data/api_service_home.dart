import 'dart:convert';
import 'dart:io';

//import 'package:alice/alice.dart';
//import 'package:alice/core/alice_http_extensions.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:teklub/auth/models/get_files_models.dart';
import 'package:teklub/home/models/api_models/check_info_model.dart';
import 'package:teklub/home/models/api_models/faq_model.dart';
import 'package:teklub/home/models/api_models/get_money_history_model.dart';
import 'package:teklub/home/models/api_models/nachisl_model.dart';
import 'package:teklub/home/models/api_models/payment_info_model.dart';
import 'package:teklub/home/models/api_models/send_money_card_model.dart';
import 'package:teklub/home/models/api_models/send_money_phone.dart';

import '../../app/user/models/get_profile_data_model.dart';

class ApiServiceHome {
  static Future<GetFilesModels> filesGet() async {
    GetStorage storage = GetStorage();
    String url = "${storage.read('domen')}files";
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
      // print(url);
      // print(token);

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

  static Future<List> setSertificatesBuy(
      String sert_id, String amount, String wallet) async {
    GetStorage storage = GetStorage();
    String token = await storage.read('token');
    String domen = await storage.read('domen') + "user-withdrawals";
    String url = "${domen}";

    Map<String, String> headers = {
      "Accept": "application/json; charset=UTF-8",
      'Authorization': 'Bearer $token',
    };
    Map<String, String> body = {
      'certificate_id': sert_id,
      'type': 'certificate',
      'amount': amount,
      'wallet': wallet,
    };
    // print("body ${body}");
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );
      String withdrawalId;

      print(json
          .decode(
            response.body,
          )
          .toString());
      // print(url);
      if (response.headers['content-location'] != null) {
        withdrawalId = response.headers['content-location'].split('/').last;
      }
      print(response.statusCode);

      return [response.statusCode, withdrawalId];
    } on HttpException {
      return [-1];
    } on SocketException {
      return [-1];
    }
  }

  static Future<Map<String, dynamic>> getSertificatesList() async {
    GetStorage storage = GetStorage();
    String token = await storage.read('token');
    String domen = await storage.read('domen') + "certificates";
    String url = "${domen}";
    Map<String, String> headers = {
      "Accept": "application/json; charset=UTF-8",
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    // print("headers ${headers}");
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      print(url);
      print(token);

      print(json
          .decode(
            utf8.decode(response.bodyBytes),
          )
          .toString());

      if (response.statusCode == 200) {
        try {
          Map<String, dynamic> rezult =
              json.decode(utf8.decode(response.body.runes.toList()));
          return rezult;
        } catch (error) {
          return {"rezult": false};
        }
      } else {
        return {"rezult": false};
      }
    } on HttpException {
      return {"rezult": false};
    } on SocketException {
      return {"rezult": false};
    }
  }

  static Future<FaqModel> getFaqList() async {
    GetStorage storage = GetStorage();
    String token = await storage.read('token');
    String domen = await storage.read('domen');

    String url = "${domen}faqs";

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
      //   utf8.decode(response.bodyBytes),
      // )
      //     .toString());

      if (response.statusCode == 200) {
        return faqModelFromJson(response.body);
      } else {
        return ErrorRequestFaq(
            error: json
                .decode(
                  utf8.decode(response.bodyBytes),
                )
                .toString());
      }
    } on HttpException {
      return ErrorRequestFaq(error: 'Ошибка запроса.');
    } on SocketException {
      return ErrorRequestFaq(error: 'Нет соединения с сервером.');
    }
  }

  static Future<NachislModel> getNachislenie() async {
    GetStorage storage = GetStorage();
    String token = await storage.read('token');
    String domen = await storage.read('domen');

    String url = "${domen}transactions";

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

      print('_____________');
      print(url);
      print(json
          .decode(
            utf8.decode(response.bodyBytes),
          )
          .toString());

      print('_____________');
      if (response.statusCode == 200) {
        return nachislModelFromJson(response.body);
      } else {
        return ErrorRequestNachislenie(
            error: json
                .decode(
                  utf8.decode(response.bodyBytes),
                )
                .toString());
      }
    } on HttpException {
      return ErrorRequestNachislenie(error: 'Ошибка запроса.');
    } on SocketException {
      return ErrorRequestNachislenie(error: 'Нет соединения с сервером.');
    }
  }

  static Future<CheckInfoModel> getCheckInfo(checkNum) async {
    GetStorage storage = GetStorage();
    String token = await storage.read('token');
    String domen = await storage.read('domen');

    String url = "${domen}user-checks/$checkNum";

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
        return checkInfoModelFromJson(response.body);
      } else {
        return ErrorRequestCheckInfo(
            error: json
                .decode(
                  utf8.decode(response.bodyBytes),
                )
                .toString());
      }
    } on HttpException {
      return ErrorRequestCheckInfo(error: 'Ошибка запроса.');
    } on SocketException {
      return ErrorRequestCheckInfo(error: 'Нет соединения с сервером.');
    }
  }

  static Future<GetMoneyHistory> getMoneyHistory() async {
    GetStorage storage = GetStorage();
    String token = await storage.read('token');
    String domen = await storage.read('domen');

    String url = "${domen}user-withdrawals";

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
        return getMoneyHistoryFromJson(response.body);
      } else {
        return ErrorRequestCheckGetMoneyHistory(
            error: json
                .decode(
                  utf8.decode(response.bodyBytes),
                )
                .toString());
      }
    } on HttpException {
      return ErrorRequestCheckGetMoneyHistory(error: 'Ошибка запроса.');
    } on SocketException {
      return ErrorRequestCheckGetMoneyHistory(
          error: 'Нет соединения с сервером.');
    }
  }

  static Future<PaymentInfoModel> getPaymentInfo(id) async {
    GetStorage storage = GetStorage();
    String token = await storage.read('token');
    String domen = await storage.read('domen');

    String url = "${domen}user-withdrawals/$id";

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

      print('idddd${id}');

      if (response.statusCode == 200) {
        return paymentInfoModelFromJson(response.body);
      } else {
        return ErrorRequestPayment(
            error: json
                .decode(
                  utf8.decode(response.bodyBytes),
                )
                .toString());
      }
    } on HttpException {
      return ErrorRequestPayment(error: 'Ошибка запроса.');
    } on SocketException {
      return ErrorRequestPayment(error: 'Нет соединения с сервером.');
    }
  }

  static Future<List<PassportAddressAndFront>> getViewAct(id) async {
    GetStorage storage = GetStorage();
    String token = await storage.read('token');
    String domen = await storage.read('domen');

    String url = "${domen}user-withdrawals/$id/acts/download";

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
      print(json.decode(response.body)['data']);
      if (response.statusCode == 200) {
        return List.from(json.decode(response.body)['data'])
            .map((e) => PassportAddressAndFront.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } on HttpException {
      return [];
    } on SocketException {
      return [];
    }
  }

  static Future<SendMoneyCard> sendCardPayment(
      SendMoneyCard requestModel) async {
    GetStorage storage = GetStorage();
    String token = await storage.read('token');
    String domen = await storage.read('domen');
    //https://teklub-challenge.pryanik.online/api/v2/promo/25/user-withdrawals
    String url = "${domen}user-withdrawals";

    Map<String, String> headers = {
      "Accept": "application/json; charset=UTF-8",
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: sendMoneyCardToJson(requestModel),
      );

      print(response.statusCode);
      print(json
          .decode(
            utf8.decode(response.bodyBytes),
          )
          .toString());
      String withdrawalId;
      // print(url);
      if (response.headers['content-location'] != null) {
        withdrawalId = response.headers['content-location'].split('/').last;
      }

      if (response.statusCode == 201) {
        return SuccessCard(withdrawalId);
      } else if (json.decode(response.body)['code'] == 466) {
        return ErrorRequestSendMoneyCard(
            error: 'Заявка на выплату уже существует');
      } else if (json.decode(response.body)['code'] == 462) {
        final error =
            "${json.decode(response.body)['comment']}\n${json.decode(response.body)['description']}";
        return ErrorRequestSendMoneyCard(error: error);
      } else if (response.statusCode == 422) {
        return ErrorRequestSendMoneyCard(
            error: 'Сумма заявки меньше минимальной, подробнее в разделе FAQ');
      } else {
        return ErrorRequestSendMoneyCard(
            error: json.decode(response.body)['description']);
      }
    } on HttpException {
      return ErrorRequestSendMoneyCard(error: 'Ошибка запроса.');
    } on SocketException {
      return ErrorRequestSendMoneyCard(error: 'Нет соединения с сервером.');
    }
  }

  static Future<SendMoneyPhone> sendPhonePayment(
      SendMoneyPhone requestModel) async {
    GetStorage storage = GetStorage();
    String token = await storage.read('token');
    String domen = await storage.read('domen');

    String url = "${domen}user-withdrawals";

    Map<String, String> headers = {
      "Accept": "application/json; charset=UTF-8",
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: sendMoneyPhoneToJson(requestModel),
      );

      print(response.statusCode);
      print(json
          .decode(
            utf8.decode(response.bodyBytes),
          )
          .toString());

      String withdrawalId;
      // print(url);
      if (response.headers['content-location'] != null) {
        withdrawalId = response.headers['content-location'].split('/').last;
      }

      if (response.statusCode == 201) {
        return SuccessPhone(withdrawalId);
      } else if (json.decode(response.body)['code'] == 466) {
        return ErrorRequestSendMoneyPhone(
            error: 'Заявка на выплату уже существует');
      } else if (json.decode(response.body)['code'] == 462) {
        return ErrorRequestSendMoneyPhone(error: 'popup');
      } else if (response.statusCode == 422) {
        return ErrorRequestSendMoneyPhone(
            error: 'Сумма заявки меньше минимальной, подробнее в разделе FAQ');
      } else {
        return ErrorRequestSendMoneyPhone(
            error: json.decode(response.body)['description']);
      }
    } on HttpException {
      return ErrorRequestSendMoneyPhone(error: 'Ошибка запроса.');
    } on SocketException {
      return ErrorRequestSendMoneyPhone(error: 'Нет соединения с сервером.');
    }
  }
}
