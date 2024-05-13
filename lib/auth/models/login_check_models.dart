abstract class LoginAuth {}

class LoginResponseModel extends LoginAuth {
  int code;
  String message;
  String description;

  // String accessDomain;

  LoginResponseModel({
    this.code,
    this.message,
    this.description,
    // this.accessDomain,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      code: json["code"] ?? "",
      message: json["message"] ?? "",
      description: json["description"] ?? "",
      // accessDomain: json["access_domain"] ?? "",
    );
  }
  @override
  toString() {
    return "code: " +
        code.toString() +
        ", messge: " +
        message +
        ', description: ' +
        description;
  }
}

class LoginRequestModel extends LoginAuth {
  String slug;
  String phone;
  String promoCode;

  // String os;
  // String version;
  // String deviceToken;

  LoginRequestModel({
    this.slug,
    this.phone,
    this.promoCode,
    // this.os,
    // this.version,
    // this.deviceToken,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'slug': slug.trim(),
      'phone': phone.trim(),
      'promo_code': promoCode.trim(),
      // 'os': os,
      // 'version': version,
      // 'device_token': deviceToken,
    };

    return map;
  }
}

class ErrorRequestLogin extends LoginAuth {
  final String error;

  ErrorRequestLogin({
    this.error,
  });
}
