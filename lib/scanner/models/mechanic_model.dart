import 'dart:convert';
MechanicModel mechanicModelFromJson(String str) => MechanicModel.fromJson(json.decode(str));
String mechanicModelToJson(MechanicModel data) => json.encode(data.toJson());

class MechanicModel {
  MechanicModel({
      this.data,});

  MechanicModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
  }
  List<Data> data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      this.body, 
      this.title, 
      this.url,});

  Data.fromJson(dynamic json) {
    body = json['body'];
    title = json['title'];
    url = json['url'];
  }
  String body;
  String title;
  String url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['body'] = body;
    map['title'] = title;
    map['url'] = url;
    return map;
  }

}

class ErrorRequestMechanic extends MechanicModel {
  final String error;

  ErrorRequestMechanic({
    this.error,
  });
}