import 'dart:convert';

PassModel passModelFromJson(String str) => PassModel.fromJson(json.decode(str));

String passModelToJson(PassModel data) => json.encode(data.toJson());

class PassModel {
  PassModel({
    this.data,
  });

  PassModel.fromJson(dynamic json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data data;
  PassModel copyWith({
    Data data,
  }) =>
      PassModel(
        data: data ?? this.data,
      );
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
    this.id,
    this.status,
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
    this.passportAddress,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    status = json['status'];
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
    if (json['passport_front'] != null) {
      passportFront = [];
      json['passport_front'].forEach((v) {
        passportFront.add(PassportFront.fromJson(v));
      });
    }
    if (json['passport_address'] != null) {
      passportAddress = [];
      json['passport_address'].forEach((v) {
        passportAddress.add(PassportAddress.fromJson(v));
      });
    }
  }
  int id;
  String status;
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
  dynamic comment;
  List<PassportFront> passportFront;
  List<PassportAddress> passportAddress;
  Data copyWith({
    int id,
    String status,
    String seriesNumber,
    String passportNumber,
    String dateOfIssue,
    String subdivisionCode,
    String issuedBy,
    String dateOfBirth,
    String placeOfBirth,
    String dateOfRegistration,
    String placeOfRegistration,
    int userId,
    dynamic comment,
    List<PassportFront> passportFront,
    List<PassportAddress> passportAddress,
  }) =>
      Data(
        id: id ?? this.id,
        status: status ?? this.status,
        seriesNumber: seriesNumber ?? this.seriesNumber,
        passportNumber: passportNumber ?? this.passportNumber,
        dateOfIssue: dateOfIssue ?? this.dateOfIssue,
        subdivisionCode: subdivisionCode ?? this.subdivisionCode,
        issuedBy: issuedBy ?? this.issuedBy,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        placeOfBirth: placeOfBirth ?? this.placeOfBirth,
        dateOfRegistration: dateOfRegistration ?? this.dateOfRegistration,
        placeOfRegistration: placeOfRegistration ?? this.placeOfRegistration,
        userId: userId ?? this.userId,
        comment: comment ?? this.comment,
        passportFront: passportFront ?? this.passportFront,
        passportAddress: passportAddress ?? this.passportAddress,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['status'] = status;
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
    if (passportFront != null) {
      map['passport_front'] = passportFront.map((v) => v.toJson()).toList();
    }
    if (passportAddress != null) {
      map['passport_address'] = passportAddress.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

PassportAddress passportAddressFromJson(String str) =>
    PassportAddress.fromJson(json.decode(str));
String passportAddressToJson(PassportAddress data) =>
    json.encode(data.toJson());

class PassportAddress {
  PassportAddress({
    this.name,
    this.url,
  });

  PassportAddress.fromJson(dynamic json) {
    name = json['name'];
    url = json['url'];
  }
  String name;
  String url;
  PassportAddress copyWith({
    String name,
    String url,
  }) =>
      PassportAddress(
        name: name ?? this.name,
        url: url ?? this.url,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['url'] = url;
    return map;
  }
}

PassportFront passportFrontFromJson(String str) =>
    PassportFront.fromJson(json.decode(str));
String passportFrontToJson(PassportFront data) => json.encode(data.toJson());

class PassportFront {
  PassportFront({
    this.name,
    this.url,
  });

  PassportFront.fromJson(dynamic json) {
    name = json['name'];
    url = json['url'];
  }
  String name;
  String url;
  PassportFront copyWith({
    String name,
    String url,
  }) =>
      PassportFront(
        name: name ?? this.name,
        url: url ?? this.url,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['url'] = url;
    return map;
  }
}

class SuccessPass extends PassModel {
  final String message;

  SuccessPass(this.message);
}

class ErrorPass extends PassModel {
  final String message;

  ErrorPass(this.message);
}
