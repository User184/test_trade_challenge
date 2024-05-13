import 'dart:convert';

CityCheck cityCheckFromJson(String str) => CityCheck.fromJson(json.decode(str));
String cityCheckToJson(CityCheck data) => json.encode(data.toJson());

class CityCheck {
  CityCheck({
    this.data,
  });

  CityCheck.fromJson(dynamic json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data data;
  CityCheck copyWith({
    Data data,
  }) =>
      CityCheck(
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
    this.name,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  int id;
  String name;
  Data copyWith({
    int id,
    String name,
  }) =>
      Data(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}

class ErrorRequestCityCheck extends CityCheck {
  final String error;

  ErrorRequestCityCheck(
    String string, {
    this.error,
  });
}
