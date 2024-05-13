import 'dart:convert';
PermissionModel permissionModelFromJson(String str) => PermissionModel.fromJson(json.decode(str));
String permissionModelToJson(PermissionModel data) => json.encode(data.toJson());

class PermissionModel {
  PermissionModel({
      this.data,});

  PermissionModel.fromJson(dynamic json) {
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
      this.id, 
      this.name, 
      this.lastName, 
      this.patronymic, 
      this.email, 
      this.phone, 
      this.officePositionTitle, 
      this.permissions,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    lastName = json['last_name'];
    patronymic = json['patronymic'];
    email = json['email'];
    phone = json['phone'];
    officePositionTitle = json['office_position_title'];
    permissions = json['permissions'] != null ? Permissions.fromJson(json['permissions']) : null;
  }
  int id;
  String name;
  String lastName;
  String patronymic;
  String email;
  String phone;
  String officePositionTitle;
  Permissions permissions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['last_name'] = lastName;
    map['patronymic'] = patronymic;
    map['email'] = email;
    map['phone'] = phone;
    map['office_position_title'] = officePositionTitle;
    if (permissions != null) {
      map['permissions'] = permissions.toJson();
    }
    return map;
  }

}

Permissions permissionsFromJson(String str) => Permissions.fromJson(json.decode(str));
String permissionsToJson(Permissions data) => json.encode(data.toJson());
class Permissions {
  Permissions({
      this.news, 
      this.welcomescreens, 
      this.role, 
      this.promos, 
      this.products,});

  Permissions.fromJson(dynamic json) {
    news = json['news'] != null ? json['news'].cast<String>() : [];
    welcomescreens = json['welcome-screens'] != null ? json['welcome-screens'].cast<String>() : [];
    role = json['role'] != null ? json['role'].cast<String>() : [];
    promos = json['promos'] != null ? json['promos'].cast<String>() : [];
    products = json['products'] != null ? json['products'].cast<String>() : [];
  }
  List<String> news;
  List<String> welcomescreens;
  List<String> role;
  List<String> promos;
  List<String> products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['news'] = news;
    map['welcome-screens'] = welcomescreens;
    map['role'] = role;
    map['promos'] = promos;
    map['products'] = products;
    return map;
  }

}

class ErrorRequestPermission extends PermissionModel {
  final String error;

  ErrorRequestPermission({
    this.error,
  });
}