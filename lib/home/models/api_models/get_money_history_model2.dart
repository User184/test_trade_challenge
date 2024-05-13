import 'dart:convert';
GetMoneyHistory getMoneyHistoryFromJson(String str) => GetMoneyHistory.fromJson(json.decode(str));
String getMoneyHistoryToJson(GetMoneyHistory data) => json.encode(data.toJson());

class GetMoneyHistory {
  GetMoneyHistory({
    this.data,
    this.meta,});

  GetMoneyHistory.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
  List<Data> data;
  Meta meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      map['meta'] = meta.toJson();
    }
    return map;
  }

}

Meta metaFromJson(String str) => Meta.fromJson(json.decode(str));
String metaToJson(Meta data) => json.encode(data.toJson());
class Meta {
  Meta({
    this.wallets,
    this.availableMethods,
    this.cards,
    this.phone,});

  Meta.fromJson(dynamic json) {
    if (json['wallets'] != null) {
      wallets = [];
      json['wallets'].forEach((v) {
        wallets.add(Wallets.fromJson(v));
      });
    }
    availableMethods = json['available_methods'] != null ? AvailableMethods.fromJson(json['available_methods']) : null;
    if (json['cards'] != null) {
      cards = [];
      json['cards'].forEach((v) {
        cards.add(v);
      });
    }
    phone = json['phone'];
  }
  List<Wallets> wallets;
  AvailableMethods availableMethods;
  List<dynamic> cards;
  String phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (wallets != null) {
      map['wallets'] = wallets.map((v) => v.toJson()).toList();
    }
    if (availableMethods != null) {
      map['available_methods'] = availableMethods.toJson();
    }
    if (cards != null) {
      map['cards'] = cards.map((v) => v.toJson()).toList();
    }
    map['phone'] = phone;
    return map;
  }

}

AvailableMethods availableMethodsFromJson(String str) => AvailableMethods.fromJson(json.decode(str));
String availableMethodsToJson(AvailableMethods data) => json.encode(data.toJson());
class AvailableMethods {
  AvailableMethods({
    this.certificate,
    this.card,
    this.phone,});

  AvailableMethods.fromJson(dynamic json) {
    certificate = json['certificate'];
    card = json['card'];
    phone = json['phone'];
  }
  bool certificate;
  bool card;
  bool phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['certificate'] = certificate;
    map['card'] = card;
    map['phone'] = phone;
    return map;
  }

}

Wallets walletsFromJson(String str) => Wallets.fromJson(json.decode(str));
String walletsToJson(Wallets data) => json.encode(data.toJson());
class Wallets {
  Wallets({
    this.name,
    this.balance,});

  Wallets.fromJson(dynamic json) {
    name = json['name']??'';
    balance = json['balance'].toString()??'';
  }
  String name;
  String balance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['balance'] = balance;
    return map;
  }

}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
    this.amount,
    this.createdAt,
    this.id,
    this.status,
    this.title,});

  Data.fromJson(dynamic json) {
    amount = json['amount'];
    createdAt = json['created_at'];
    id = json['id'];
    status = json['status'];
    title = json['title'];
  }
  String amount;
  String createdAt;
  int id;
  String status;
  String title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = amount;
    map['created_at'] = createdAt;
    map['id'] = id;
    map['status'] = status;
    map['title'] = title;
    return map;
  }

}

class ErrorRequestCheckGetMoneyHistory extends GetMoneyHistory {
  final String error;

  ErrorRequestCheckGetMoneyHistory({
    this.error,
  });
}