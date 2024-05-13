import 'dart:convert';

ApiFileGetModel apiFileGetModelFromJson(String str) =>
    ApiFileGetModel.fromJson(json.decode(str));

String apiFileGetModelToJson(ApiFileGetModel data) =>
    json.encode(data.toJson());

class ApiFileGetModel {
  ApiFileGetModel({
    this.data,
  });

  ApiFileGetModel.fromJson(dynamic json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data data;
  ApiFileGetModel copyWith({
    List<Data> data,
  }) =>
      ApiFileGetModel(
        data: data ?? this.data,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      // map['data'] = data.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    this.name,
    this.url,
  });

  Data.fromJson(dynamic json) {
    name = json['name'];
    url = json['url'];
  }
  String name;
  String url;
  Data copyWith({
    String name,
    String url,
  }) =>
      Data(
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

class SuccessGetFile extends ApiFileGetModel {
  final String message;

  SuccessGetFile(this.message);
}

class ErrorGetFile extends ApiFileGetModel {
  final String message;

  ErrorGetFile(this.message);
}
