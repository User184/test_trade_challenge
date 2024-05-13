import 'dart:convert';

PaymentInfoModel paymentInfoModelFromJson(String str) =>
    PaymentInfoModel.fromJson(json.decode(str));
String paymentInfoModelToJson(PaymentInfoModel data) =>
    json.encode(data.toJson());

class PaymentInfoModel {
  PaymentInfoModel({
    this.data,
  });

  PaymentInfoModel.fromJson(dynamic json) {
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
    this.amount,
    this.createdAt,
    this.status,
    this.type,
    this.comment,
    this.card,
    this.phone,
    this.certificate,
  });

  Data.fromJson(dynamic json) {
    amount = json['amount'].toString() ?? '';
    createdAt = json['created_at'] ?? '';
    status = json['status'] ?? '';
    type = json['type'] ?? '';
    comment = json['comment'] ?? '';
    card = json['card'] ?? '';
    phone = json['phone'] ?? '';
    actStatus = json['act_status'] ?? '';
    certificate = json['certificate'] ?? {"certificate": false};
  }
  String amount;
  String createdAt;
  String status;
  String type;
  String actStatus;
  String comment;
  String card;
  String phone;
  Map<String, dynamic> certificate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = amount;
    map['created_at'] = createdAt;
    map['status'] = status;
    map['type'] = type;
    map['comment'] = comment;
    map['card'] = card;
    map['phone'] = phone;
    map['certificate'] = certificate;
    return map;
  }
}

class ErrorRequestPayment extends PaymentInfoModel {
  final String error;

  ErrorRequestPayment({
    this.error,
  });
}
