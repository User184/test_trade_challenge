import 'dart:convert';

GetProfileDataModel getProfileDataModelFromJson(String str) =>
    GetProfileDataModel.fromJson(json.decode(str));

String getProfileDataModelToJson(GetProfileDataModel data) =>
    json.encode(data.toJson());

class GetProfileDataModel {
  GetProfileDataModel({
    this.data,
  });

  GetProfileDataModel.fromJson(dynamic json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Data data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data.toJson();
    }
    return map;
  }
}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    this.inn,
    this.appRole,
    this.id,
    this.tradePointId,
    this.email,
    this.phone,
    this.patronymic,
    this.lastName,
    this.name,
    this.lastVisit,
    this.createdAt,
    this.pointsBalance,
    this.officePositionTitle,
    this.prize,
    this.withdrawnToTheCard,
    this.totalForSale,
    this.totalReceived,
    this.noActiveDays,
    this.rubBalance,
    this.tradePoint,
    this.passportData,
    this.region,
    this.city,
    this.avatar,
    this.specializations,
    this.referralCode,
  });

  Data.fromJson(dynamic json) {
    inn = json['inn'];
    appRole = json['app_role'];
    id = json['id'];
    tradePointId = json['trade_point_id'];
    email = json['email'];
    phone = json['phone'];
    patronymic = json['patronymic'];
    lastName = json['last_name'];
    name = json['name'];
    lastVisit = json['last_visit'];
    createdAt = json['created_at'];
    pointsBalance = json['points_balance'];
    officePositionTitle = json['office_position_title'];
    prize = json['prize'];
    withdrawnToTheCard = json['withdrawn_to_the_card'];
    totalForSale = json['total_for_sale'];
    totalReceived = json['total_received'];
    noActiveDays = json['no_active_days'];
    rubBalance = json['rub_balance'];
    referralCode = json['referral_code'];
    tradePoint = json['trade_point'] != null
        ? TradePoint.fromJson(json['trade_point'])
        : null;
    passportData = json['passport_data'] != null
        ? PassportData.fromJson(json['passport_data'])
        : null;
    avatar = json['avatar'];
    region = json['region'];
    city = json['city'];
    specializations = json['specializations'] != null
        ? List.from(json['specializations'])
            .map((e) => Specializations.fromJson(e))
            .toList()
        : null;
  }

  String inn;
  dynamic appRole;
  int id;
  int tradePointId;
  List<Specializations> specializations;
  String email;
  String referralCode;
  String phone;
  String patronymic;
  String lastName;
  String name;
  dynamic lastVisit;
  String createdAt;
  int pointsBalance;
  String officePositionTitle;
  String region;
  String city;
  int prize;
  int withdrawnToTheCard;
  int totalForSale;
  int totalReceived;
  dynamic noActiveDays;
  int rubBalance;
  TradePoint tradePoint;
  PassportData passportData;
  dynamic avatar;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['inn'] = inn;
    map['app_role'] = appRole;
    map['id'] = id;
    map['trade_point_id'] = tradePointId;
    map['email'] = email;
    map['phone'] = phone;
    map['patronymic'] = patronymic;
    map['last_name'] = lastName;
    map['name'] = name;
    map['last_visit'] = lastVisit;
    map['created_at'] = createdAt;
    map['points_balance'] = pointsBalance;
    map['office_position_title'] = officePositionTitle;
    map['prize'] = prize;
    map['withdrawn_to_the_card'] = withdrawnToTheCard;
    map['total_for_sale'] = totalForSale;
    map['total_received'] = totalReceived;
    map['no_active_days'] = noActiveDays;
    map['rub_balance'] = rubBalance;
    if (tradePoint != null) {
      map['trade_point'] = tradePoint.toJson();
    }
    if (passportData != null) {
      map['passport_data'] = passportData.toJson();
    }
    map['avatar'] = avatar;
    map['region'] = region;
    map['city'] = city;
    return map;
  }
}

class Specializations {
  Specializations({
    this.id,
    this.name,
    this.alias,
    this.many,
  });

  int id;
  String name;
  String alias;
  bool many;

  Specializations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    alias = json['alias'];
    many = json['many'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['alias'] = alias;
    _data['many'] = many;
    return _data;
  }
}

PassportData passportDataFromJson(String str) =>
    PassportData.fromJson(json.decode(str));

String passportDataToJson(PassportData data) => json.encode(data.toJson());

class PassportData {
  PassportData({
    this.id,
    this.approved,
    this.seriesNumber,
    this.passportNumber,
    this.dateOfIssue,
    this.subdivisionCode,
    this.issuedBy,
    this.dateOfBirth,
    this.placeOfBirth,
    this.dateOfRegistration,
    this.placeOfRegistration,
    this.userId,
    this.comment,
    this.status,
    this.passportFront,
    this.passportAddress,
  });

  PassportData.fromJson(dynamic json) {
    id = json['id'];
    approved = json['approved'];
    seriesNumber = json['series_number'];
    passportNumber = json['passport_number'];
    dateOfIssue = json['date_of_issue'];
    subdivisionCode = json['subdivision_code'];
    issuedBy = json['issued_by'];
    dateOfBirth = json['date_of_birth'];
    placeOfBirth = json['place_of_birth'];
    dateOfRegistration = json['date_of_registration'];
    placeOfRegistration = json['place_of_registration'];
    userId = json['user_id'];
    status = json['status'];
    comment = json['comment'];
    passportFront = json['passport_front'] != null
        ? List.from(json['passport_front'])
            .map((e) => PassportAddressAndFront.fromJson(e))
            .toList()
        : null;
    passportAddress = json['passport_address'] != null
        ? List.from(json['passport_address'])
            .map((e) => PassportAddressAndFront.fromJson(e))
            .toList()
        : null;
  }

  int id;
  bool approved;
  String seriesNumber;
  String passportNumber;
  String status;
  String dateOfIssue;
  String subdivisionCode;
  String issuedBy;
  String dateOfBirth;
  String placeOfBirth;
  String dateOfRegistration;
  String placeOfRegistration;
  int userId;
  String comment;
  List<PassportAddressAndFront> passportFront;
  List<PassportAddressAndFront> passportAddress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['approved'] = approved;
    map['series_number'] = seriesNumber;
    map['passport_number'] = passportNumber;
    map['date_of_issue'] = dateOfIssue;
    map['subdivision_code'] = subdivisionCode;
    map['issued_by'] = issuedBy;
    map['date_of_birth'] = dateOfBirth;
    map['place_of_birth'] = placeOfBirth;
    map['date_of_registration'] = dateOfRegistration;
    map['place_of_registration'] = placeOfRegistration;
    map['user_id'] = userId;
    map['comment'] = comment;
    map['passport_front'] = passportFront;
    map['passport_address'] = passportAddress;
    return map;
  }
}

TradePoint tradePointFromJson(String str) =>
    TradePoint.fromJson(json.decode(str));

String tradePointToJson(TradePoint data) => json.encode(data.toJson());

class TradePoint {
  TradePoint({
    this.id,
    this.active,
    this.comment,
    this.inn,
    this.name,
    this.address,
    this.city,
    this.region,
    this.district,
    this.distributor,
    this.code,
  });

  TradePoint.fromJson(dynamic json) {
    id = json['id'];
    active = json['active'];
    comment = json['comment'];
    inn = json['inn'];
    name = json['name'];
    address = json['address'];
    city = json['city'];
    region = json['region'];
    district = json['district'];
    distributor = json['distributor'];
    code = json['code'];
  }

  int id;
  bool active;
  String comment;
  String inn;
  String name;
  String address;
  String city;
  String region;
  String district;
  String distributor;
  String code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['active'] = active;
    map['comment'] = comment;
    map['inn'] = inn;
    map['name'] = name;
    map['address'] = address;
    map['city'] = city;
    map['region'] = region;
    map['district'] = district;
    map['distributor'] = distributor;
    map['code'] = code;
    return map;
  }
}

class SendPassportRequestModel extends GetProfileDataModel {
  String name;
  String lastName;
  String patranomic;
  String seriesNumber;
  String passportNumber;
  String dateOfIssue;
  String subdivisionCode;
  String issuedBy;
  String dateOfBirth;
  String placeOfBirth;
  String dateOfRegistration;
  String placeOfRegistration;
  // String inn;
  List passportData;
  dynamic passportFront;
  dynamic passportAddress;

  SendPassportRequestModel({
    this.seriesNumber,
    this.passportNumber,
    this.dateOfIssue,
    this.subdivisionCode,
    this.issuedBy,
    this.dateOfBirth,
    this.placeOfBirth,
    this.dateOfRegistration,
    this.placeOfRegistration,
    this.passportData,
    this.passportFront,
    this.passportAddress,
    this.name,
    // this.inn,
    this.lastName,
    this.patranomic,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['series_number'] = seriesNumber;
    map['passport_number'] = passportNumber;
    map['date_of_issue'] = dateOfIssue;
    map['subdivision_code'] = subdivisionCode;
    map['issued_by'] = issuedBy;
    map['date_of_birth'] = dateOfBirth;
    map['place_of_birth'] = placeOfBirth;
    map['date_of_registration'] = dateOfRegistration;
    // map['inn'] = inn;
    map['place_of_registration'] = placeOfRegistration;
    map['passport_data'] = [passportFront, passportAddress];

    map['passport_front'] = passportFront;
    map['passport_address'] = passportAddress;
    map['name'] = name;
    map['last_name'] = lastName;
    map['patronymic'] = patranomic;

    return map;
  }
}

class ErrorRequestProfileData extends GetProfileDataModel {
  final String error;

  ErrorRequestProfileData({
    this.error,
  });
}

class PassportAddressAndFront {
  PassportAddressAndFront({
    this.name,
    this.url,
  });
  String name;
  String url;

  PassportAddressAndFront.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['url'] = url;
    return _data;
  }
}

class Success extends GetProfileDataModel {
  final String message;

  Success(this.message);
}

class ErrorMsg extends GetProfileDataModel {
  final String message;

  ErrorMsg(this.message);
}
