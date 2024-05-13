import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:teklub/catalog/models/catalog_model.dart';

class ApiServiceCatalog {
  // static Future<CatalogModel> getCatalog() async {
  //
  //   GetStorage storage = GetStorage();
  //   String url = "${storage.read('domen')}products";
  //   String token = await storage.read('token');
  //
  //   Map<String, String> headers = {
  //     "Accept": "application/json; charset=UTF-8",
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   };
  //   try {
  //     final response = await http.get(
  //       Uri.parse(url),
  //       headers: headers,
  //     );
  //     if (response.statusCode == 200) {
  //       return catalogModelFromJson(response.body);
  //     } else {
  //       return ErrorRequestCatalog(
  //           error: json
  //               .decode(
  //                 utf8.decode(response.bodyBytes),
  //               )
  //               .toString());
  //     }
  //   } on HttpException {
  //     return ErrorRequestCatalog(error: 'Ошибка запроса.');
  //   } on SocketException {
  //     return ErrorRequestCatalog(error: 'Нет соединения с сервером.');
  //   }
  // }

  static Future<CatalogModel> searchCatalog(String name) async {
    GetStorage storage = GetStorage();
    String url = "${storage.read('domen')}products?s=$name";
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
      // print(json
      //     .decode(
      //   utf8.decode(response.bodyBytes),
      // )
      //     .toString());
      if (response.statusCode == 200) {
        return catalogModelFromJson(response.body);
      } else {
        return ErrorRequestCatalog(
            error: json
                .decode(
                  utf8.decode(response.bodyBytes),
                )
                .toString());
      }
    } on HttpException {
      return ErrorRequestCatalog(error: 'Ошибка запроса.');
    } on SocketException {
      return ErrorRequestCatalog(error: 'Нет соединения с сервером.');
    }
  }

  static Future<CatalogModel> searchCatalogScu(
    pag,
    page,
    type,
  ) async {
    // print(type);
    // print(page);
    GetStorage storage = GetStorage();
    String url =
        "${storage.read('domen')}products?order=$type&paginate=$pag&page=$page";
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

      if (response.statusCode == 200) {
        return catalogModelFromJson(response.body);
      } else {
        return ErrorRequestCatalog(
            error: json
                .decode(
                  utf8.decode(response.bodyBytes),
                )
                .toString());
      }
    } on HttpException {
      return ErrorRequestCatalog(error: 'Ошибка запроса.');
    } on SocketException {
      return ErrorRequestCatalog(error: 'Нет соединения с сервером.');
    }
  }

  static Future<CatalogModel> searchCatalogBackScu(
    pag,
    page,
    type,
  ) async {
    // print(type);
    GetStorage storage = GetStorage();
    String url =
        "${storage.read('domen')}products?order_desc=$type&paginate=$pag&page=$page";
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

      if (response.statusCode == 200) {
        return catalogModelFromJson(response.body);
      } else {
        return ErrorRequestCatalog(
            error: json
                .decode(
                  utf8.decode(response.bodyBytes),
                )
                .toString());
      }
    } on HttpException {
      return ErrorRequestCatalog(error: 'Ошибка запроса.');
    } on SocketException {
      return ErrorRequestCatalog(error: 'Нет соединения с сервером.');
    }
  }

  static Future<CatalogModel> getCatalog(
    pag,
    page,
  ) async {
    GetStorage storage = GetStorage();
    String url = "${storage.read('domen')}products?paginate=$pag&page=$page";
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
      // print(response.statusCode);
      // print(json
      //     .decode(
      //   utf8.decode(response.bodyBytes),
      // )
      //     .toString());

      if (response.statusCode == 200) {
        return catalogModelFromJson(response.body);
      } else {
        return ErrorRequestCatalog(
            error: json
                .decode(
                  utf8.decode(response.bodyBytes),
                )
                .toString());
      }
    } on HttpException {
      return ErrorRequestCatalog(error: 'Ошибка запроса.');
    } on SocketException {
      return ErrorRequestCatalog(error: 'Нет соединения с сервером.');
    }
  }
}
