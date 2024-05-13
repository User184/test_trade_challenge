abstract class PromoAuth {}

class PromoResponseModel extends PromoAuth {
  int code;
  String message;
  String description;

  // String accessDomain;

  PromoResponseModel({
    this.code,
    this.message,
    this.description,
    // this.accessDomain,
  });

  factory PromoResponseModel.fromJson(Map<String, dynamic> json) {
    return PromoResponseModel(
      code: json["code"] ?? "",
      message: json["message"] ?? "",
      description: json["description"] ?? "",
      // accessDomain: json["access_domain"] ?? "",
    );
  }
  @override
  toString() {
    return "code: " + code.toString() + ", messge: " + message + ', description: ' + description;
  }
}

class PromoRequestModel extends PromoAuth {
  String slug;
  String phone;
  String promoCode;

  PromoRequestModel({
    this.slug,
    this.phone,
    this.promoCode,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'slug': slug.trim(),
      'phone': phone.trim(),
      'promo_code': promoCode.trim(),
    };

    return map;
  }


}

class ErrorRequestPromo extends PromoAuth {
  final String error;

  ErrorRequestPromo({
    this.error,
  });
}
