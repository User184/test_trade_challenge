import 'dart:convert';
NachislenieModel nachislenieModelFromJson(String str) => NachislenieModel.fromJson(json.decode(str));
String nachislenieModelToJson(NachislenieModel data) => json.encode(data.toJson());

class NachislenieModel {
  NachislenieModel({
      this.data,});

  NachislenieModel.fromJson(dynamic json) {
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
      this.id, 
      this.amount, 
      this.createdAt, 
      this.status, 
      this.causer, 
      this.causerId,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    amount = json['amount'];
    createdAt = json['created_at'];
    status = json['status'];
    causer = json['causer'];
    causerId = json['causer_id'];
  }
  int id;
  int amount;
  String createdAt;
  String status;
  String causer;
  int causerId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['amount'] = amount;
    map['created_at'] = createdAt;
    map['status'] = status;
    map['causer'] = causer;
    map['causer_id'] = causerId;
    return map;
  }

}

class ErrorRequestNachislenie extends NachislenieModel {
  final String error;

  ErrorRequestNachislenie({
    this.error,
  });
}