import 'dart:convert';

NachislModel nachislModelFromJson(String str) =>
    NachislModel.fromJson(json.decode(str));
String nachislModelToJson(NachislModel data) => json.encode(data.toJson());

class NachislModel {
  NachislModel({
    this.data,
  });

  NachislModel.fromJson(dynamic json) {
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
  Data(
      {this.id,
      this.amount,
      this.createdAt,
      this.status,
      this.causerId,
      this.causer,
      this.title});

  Data.fromJson(dynamic json) {
    id = json['id'].toString();
    amount = json['amount'].toString();
    createdAt = json['created_at'].toString();
    status = json['status'].toString();
    causerId = json['causer_id'].toString();
    causer = json['causer'].toString();
    title = json['title'].toString();
  }
  String id;
  String amount;
  String createdAt;
  String status;
  String causerId;
  String causer;
  String title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['amount'] = amount;
    map['created_at'] = createdAt;
    map['status'] = status;
    map['causer_id'] = causerId;
    map['causer'] = causer;
    map['title'] = title;
    return map;
  }
}

class ErrorRequestNachislenie extends NachislModel {
  final String error;

  ErrorRequestNachislenie({
    this.error,
  });
}
