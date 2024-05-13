import 'dart:convert';

PermissionModel2 permissionModel2FromJson(String str) =>
    PermissionModel2.fromJson(json.decode(str));

String permissionModel2ToJson(PermissionModel2 data) =>
    json.encode(data.toJson());

class PermissionModel2 {
  PermissionModel2({
    this.data,
  });

  PermissionModel2.fromJson(dynamic json) {
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
  Data(
      {this.id,
      this.name,
      this.lastName,
      this.patronymic,
      this.email,
      this.phone,
      this.city,
      this.rubBalance,
      this.pointsBalance,
      this.officePositionTitle,
      this.permissions,
      this.feedBackEmail});

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    lastName = json['last_name'];
    patronymic = json['patronymic'];
    email = json['email'];
    phone = json['phone'];
    city = json['city'];
    rubBalance = json['rub_balance'];
    pointsBalance = json['points_balance'];
    officePositionTitle = json['office_position_title'];
    permissions = json['permissions'] != null
        ? Permissions.fromJson(json['permissions'])
        : null;
    feedBackEmail = json['feedback_email'];
  }

  int id;
  String name;
  String lastName;
  String patronymic;
  String email;
  String phone;
  String city;
  int rubBalance;
  int pointsBalance;
  String officePositionTitle;
  Permissions permissions;
  String feedBackEmail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['last_name'] = lastName;
    map['patronymic'] = patronymic;
    map['email'] = email;
    map['phone'] = phone;
    map['city'] = city;
    map['rub_balance'] = rubBalance;
    map['points_balance'] = pointsBalance;
    map['office_position_title'] = officePositionTitle;
    map['feedback_email'] = feedBackEmail;
    if (permissions != null) {
      map['permissions'] = permissions.toJson();
    }
    return map;
  }
}

Permissions permissionsFromJson(String str) =>
    Permissions.fromJson(json.decode(str));

String permissionsToJson(Permissions data) => json.encode(data.toJson());

class Permissions {
  Permissions({
    this.faqs,
    this.news,
    this.welcomescreens,
    this.files,
    this.promos,
    this.products,
  });

  Permissions.fromJson(dynamic json) {
    faqs = json['faqs'] != null ? json['faqs'].cast<String>() : [];
    news = json['news'] != null ? json['news'].cast<String>() : [];
    welcomescreens = json['welcome-screens'] != null
        ? json['welcome-screens'].cast<String>()
        : [];
    files = json['files'] != null ? json['files'].cast<String>() : [];
    promos = json['promos'] != null ? json['promos'].cast<String>() : [];
    products = json['products'] != null ? json['products'].cast<String>() : [];
  }

  List<String> faqs;
  List<String> news;
  List<String> welcomescreens;
  List<String> files;
  List<String> promos;
  List<String> products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['faqs'] = faqs;
    map['news'] = news;
    map['welcome-screens'] = welcomescreens;
    map['files'] = files;
    map['promos'] = promos;
    map['products'] = products;
    return map;
  }
}

class ErrorRequestPermission2 extends PermissionModel2 {
  final String error;

  ErrorRequestPermission2({
    this.error,
  });
}
