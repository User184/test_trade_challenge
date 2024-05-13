abstract class RegisterAuth {}

class RegisterResponseModel extends RegisterAuth {
  int code;
  String message;
  String description;
  List tradePointName;
  List tradePointCity;
  List tradePointAddress;

  RegisterResponseModel({
    this.code,
    this.message,
    this.description,
    this.tradePointName,
    this.tradePointCity,
    this.tradePointAddress,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      code: json["code"] ?? "",
      message: json["message"] ?? "",
      description: json["description"] ?? "",
      tradePointName: json["trade_point_name"] ?? [],
      tradePointCity: json["trade_point_city"] ?? [],
      tradePointAddress: json["trade_point_address"] ?? [],
    );
  }

  @override
  toString() {
    return "code: " +
        code.toString() +
        ", messge: " +
        message +
        ', description: ' +
        description ;
  }
}


class RegisterRequestModel extends RegisterAuth {
  final String officePositionId;
  final String name;
  final String lastName;
  final String patronymic;
  final String phone;
  final String email;
  final String slug;
  final String password;
  final String promoCode;
  final String inn;

  RegisterRequestModel({
    this.slug,
    this.phone,
    this.password,
    this.promoCode,
    this.name,
    this.lastName,
    this.patronymic,
    this.email,
    this.officePositionId,
    this.inn,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "slug": slug,
      "phone": phone,
      "password": password,
      "promo_code": promoCode,
      "name": name,
      "last_name": lastName,
      "patronymic": patronymic,
      "email": email,
      "trade_point_inn": inn,
      "office_position_id": officePositionId,
    };

    return map;
  }
}

class ErrorRequestRegister extends RegisterAuth {
  final String error;

  ErrorRequestRegister({
    this.error,
  });
}
