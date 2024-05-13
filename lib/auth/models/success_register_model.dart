import 'package:get_storage/get_storage.dart';
import 'package:teklub/auth/models/register_model.dart';

class SuccessRegisterResponseModel extends RegisterAuth {
  int code;
  String tokenType;
  int expiresIn;
  String accessToken;
  String refreshToken;
  String accessDomain;
  int regionId;

  SuccessRegisterResponseModel(
      {this.tokenType,
      this.expiresIn,
      this.accessToken,
      this.refreshToken,
      this.accessDomain,
      this.regionId});

  factory SuccessRegisterResponseModel.fromJson(Map<String, dynamic> json) {
    GetStorage storage = GetStorage();
    storage.write('token', json["access_token"]);
    return SuccessRegisterResponseModel(
      tokenType: json["token_type"],
      expiresIn: json["expires_in"],
      accessToken: json["access_token"],
      refreshToken: json["refresh_token"],
      accessDomain: json["access_domain"],
    );
  }
}

class SuccessRegisterRequestModel extends RegisterAuth {
  final String slug;
  final String phone;
  final String password;
  final String promoCode;
  final String name;
  final String lastName;
  final String patronymic;
  final String email;
  final String officePositionId;
  final String mkCode;
  final String inn;
  final String tradePointName;
  final String tradePointCity;
  final String tradePointAddress;
  final String os;
  final String version;
  final String deviceToken;
  final String city;
  final int regionId;

  SuccessRegisterRequestModel(
      {this.slug,
      this.phone,
      this.password,
      this.promoCode,
      this.name,
      this.inn,
      this.lastName,
      this.patronymic,
      this.email,
      this.officePositionId,
      this.mkCode,
      this.tradePointName,
      this.tradePointCity,
      this.tradePointAddress,
      this.os,
      this.version,
      this.deviceToken,
      this.regionId,
      this.city});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "slug": slug ?? '',
      "phone": phone ?? '',
      "password": password ?? '',
      "promo_code": promoCode ?? '',
      "name": name ?? '',
      "last_name": lastName ?? '',
      "patronymic": patronymic ?? '',
      "email": email ?? '',
      "inn": inn ?? '',
      "office_position_id": officePositionId ?? '',
      "trade_point_inn": mkCode ?? '',
      'trade_point_name': tradePointName ?? '',
      'trade_point_city': tradePointCity ?? '',
      'trade_point_address': tradePointAddress ?? '',
      // "os": os ?? '',
      // "version": version ?? '',
      // "device_token": deviceToken ?? '',
      // "region_id": regionId.toString(),
      // "city": city,
    };

    return map;
  }
}

class ErrorRequestRegisterSuccess extends RegisterAuth {
  ErrorRequestRegisterSuccess({
    this.message,
    this.errors,
  });
  String message;
  Errors errors;

  ErrorRequestRegisterSuccess.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    errors = Errors.fromJson(json['errors']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['errors'] = errors.toJson();
    return _data;
  }
}

class Errors {
  Errors({
    this.tradePointInn,
  });
  List<String> tradePointInn;
  String message;
  Errors.fromJson(Map<String, dynamic> json) {
    if (json['trade_point_inn'] != null) {
      tradePointInn = List.castFrom<dynamic, String>(json['trade_point_inn']);
    } else {
      message = json.toString();
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['trade_point_inn'] = tradePointInn;
    return _data;
  }
}
