import 'dart:convert';
GetProfileDataModel2 getProfileDataModel2FromJson(String str) => GetProfileDataModel2.fromJson(json.decode(str));
String getProfileDataModel2ToJson(GetProfileDataModel2 data) => json.encode(data.toJson());

class GetProfileDataModel2 {
  GetProfileDataModel2({
      this.data,});

  GetProfileDataModel2.fromJson(dynamic json) {
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
      this.createdAt, 
      this.appRole, 
      this.inn, 
      this.id, 
      this.lastVisit, 
      this.name, 
      this.lastName, 
      this.patronymic, 
      this.phone, 
      this.email, 
      this.os, 
      this.tradePointId, 
      this.withdrawnToTheCardInProcess, 
      this.withdrawnToThePhoneInProcess, 
      this.withdrawnToThePhone, 
      this.pointsBalance, 
      this.officePositionTitle, 
      this.withdrawnToTheCard, 
      this.totalForSale, 
      this.totalReceived, 
      this.noActiveDays, 
      this.rubBalance, 
      this.totalForCashback, 
      this.totalForTests, 
      this.totalForPriceMonitoring, 
      this.tradePoint, 
      this.passportData, 
      this.avatar,});

  Data.fromJson(dynamic json) {
    createdAt = json['created_at'];
    appRole = json['app_role'];
    inn = json['inn'];
    id = json['id'];
    lastVisit = json['last_visit'];
    name = json['name'];
    lastName = json['last_name'];
    patronymic = json['patronymic'];
    phone = json['phone'];
    email = json['email'];
    os = json['os'];
    tradePointId = json['trade_point_id'];
    withdrawnToTheCardInProcess = json['withdrawn_to_the_card_in_process'];
    withdrawnToThePhoneInProcess = json['withdrawn_to_the_phone_in_process'];
    withdrawnToThePhone = json['withdrawn_to_the_phone'];
    pointsBalance = json['points_balance'];
    officePositionTitle = json['office_position_title'];
    withdrawnToTheCard = json['withdrawn_to_the_card'];
    totalForSale = json['total_for_sale'];
    totalReceived = json['total_received'];
    noActiveDays = json['no_active_days'];
    rubBalance = json['rub_balance'];
    totalForCashback = json['total_for_cashback'];
    totalForTests = json['total_for_tests'];
    totalForPriceMonitoring = json['total_for_price_monitoring'];
    tradePoint = json['trade_point'] != null ? Trade_point.fromJson(json['tradePoint']) : null;
    passportData = json['passport_data'] != null ? Passport_data.fromJson(json['passportData']) : null;
    avatar = json['avatar'];
  }
  String createdAt;
  dynamic appRole;
  String inn;
  int id;
  String lastVisit;
  String name;
  String lastName;
  String patronymic;
  String phone;
  String email;
  String os;
  int tradePointId;
  int withdrawnToTheCardInProcess;
  int withdrawnToThePhoneInProcess;
  int withdrawnToThePhone;
  int pointsBalance;
  String officePositionTitle;
  int withdrawnToTheCard;
  int totalForSale;
  String totalReceived;
  int noActiveDays;
  String rubBalance;
  String totalForCashback;
  int totalForTests;
  String totalForPriceMonitoring;
  Trade_point tradePoint;
  Passport_data passportData;
  dynamic avatar;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['created_at'] = createdAt;
    map['app_role'] = appRole;
    map['inn'] = inn;
    map['id'] = id;
    map['last_visit'] = lastVisit;
    map['name'] = name;
    map['last_name'] = lastName;
    map['patronymic'] = patronymic;
    map['phone'] = phone;
    map['email'] = email;
    map['os'] = os;
    map['trade_point_id'] = tradePointId;
    map['withdrawn_to_the_card_in_process'] = withdrawnToTheCardInProcess;
    map['withdrawn_to_the_phone_in_process'] = withdrawnToThePhoneInProcess;
    map['withdrawn_to_the_phone'] = withdrawnToThePhone;
    map['points_balance'] = pointsBalance;
    map['office_position_title'] = officePositionTitle;
    map['withdrawn_to_the_card'] = withdrawnToTheCard;
    map['total_for_sale'] = totalForSale;
    map['total_received'] = totalReceived;
    map['no_active_days'] = noActiveDays;
    map['rub_balance'] = rubBalance;
    map['total_for_cashback'] = totalForCashback;
    map['total_for_tests'] = totalForTests;
    map['total_for_price_monitoring'] = totalForPriceMonitoring;
    if (tradePoint != null) {
      map['trade_point'] = tradePoint.toJson();
    }
    if (passportData != null) {
      map['passport_data'] = passportData.toJson();
    }
    map['avatar'] = avatar;
    return map;
  }

}

Passport_data passport_dataFromJson(String str) => Passport_data.fromJson(json.decode(str));
String passport_dataToJson(Passport_data data) => json.encode(data.toJson());
class Passport_data {
  Passport_data({
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
      this.passportFront, 
      this.passportAddress,});

  Passport_data.fromJson(dynamic json) {
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
    comment = json['comment'];
    passportFront = json['passport_front'];
    passportAddress = json['passport_address'];
  }
  int id;
  bool approved;
  String seriesNumber;
  String passportNumber;
  String dateOfIssue;
  String subdivisionCode;
  String issuedBy;
  String dateOfBirth;
  String placeOfBirth;
  String dateOfRegistration;
  String placeOfRegistration;
  int userId;
  String comment;
  dynamic passportFront;
  dynamic passportAddress;

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

Trade_point trade_pointFromJson(String str) => Trade_point.fromJson(json.decode(str));
String trade_pointToJson(Trade_point data) => json.encode(data.toJson());
class Trade_point {
  Trade_point({
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
      this.code,});

  Trade_point.fromJson(dynamic json) {
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