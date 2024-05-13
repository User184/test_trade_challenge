import 'package:teklub/auth/models/specs_model.dart';

abstract class SmsAuth {}

class SmsResponseModel extends SmsAuth {
  String code;
  String tokenType;
  int expiresIn;
  String accessToken;
  String refreshToken;
  String accessDomain;

  SmsResponseModel({
    this.tokenType,
    this.expiresIn,
    this.accessToken,
    this.refreshToken,
    this.accessDomain,
  });

  factory SmsResponseModel.fromJson(Map<String, dynamic> json) {
    return SmsResponseModel(
      tokenType: json["token_type"],
      expiresIn: json["expires_in"],
      accessToken: json["access_token"],
      refreshToken: json["refresh_token"],
      accessDomain: json["access_domain"],
    );
  }
}

class SmsResponseModelReg extends SmsAuth {
  int code;
  String message;
  String description;
  List<List<String>> officePositions;
  String accessDomain;
  List<FilseModel> files;
  List<SpecsModel> specializations;

  SmsResponseModelReg({
    this.code,
    this.message,
    this.description,
    this.officePositions,
    this.accessDomain,
    this.files,
    this.specializations,
  });

  factory SmsResponseModelReg.fromJson(Map<String, dynamic> json) {
    List<List<String>> resultPos = [];
    if (json["office_positions"].isEmpty) {
      resultPos = [];
    } else {
      final pos = json["office_positions"] as Map;

      if (pos.isNotEmpty) {
        for (final name in pos.entries) {
          resultPos.add([name.key, name.value]);
        }
      } else {
        resultPos = [];
      }
    }
    print(json['specialization_segments']);

    return SmsResponseModelReg(
        code: json["code"],
        message: json["message"],
        description: json["description"],
        officePositions: resultPos,
        accessDomain: json["access_domain"],
        files: json["files"] != null
            ? List.from(json['files'])
                .map((e) => FilseModel.fromJson(e))
                .toList()
            : null,
        specializations: json['specialization_segments'] != null
            ? List.from(json['specialization_segments'])
                .map((e) => SpecsModel.fromJson(e))
                .toList()
            : null);
  }
}

class SmsRequestModel extends SmsAuth {
  String slug;
  String phone;
  String password;
  String os;
  String version;
  String deviceToken;
  String promoCode;

  SmsRequestModel({
    this.slug,
    this.phone,
    this.password,
    this.os,
    this.version,
    this.deviceToken,
    this.promoCode,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'slug': slug,
      'phone': phone,
      'password': password,
      'os': os,
      'version': version,
      'device_token': deviceToken,
      if (promoCode != null) 'promo_code': promoCode,
    };

    return map;
  }
}

class ErrorRequestSms extends SmsAuth {
  final String error;
  final int code;

  ErrorRequestSms({
    this.error,
    this.code,
  });
}

class FilseModel {
  FilseModel({
    this.type,
    this.url,
  });

  FilseModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    url = json['url'];
  }
  String type;
  String url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['url'] = url;
    return map;
  }
}
