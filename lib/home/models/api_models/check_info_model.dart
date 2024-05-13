import 'dart:convert';
CheckInfoModel checkInfoModelFromJson(String str) => CheckInfoModel.fromJson(json.decode(str));
String checkInfoModelToJson(CheckInfoModel data) => json.encode(data.toJson());

class CheckInfoModel {
  CheckInfoModel({
      this.data,});

  CheckInfoModel.fromJson(dynamic json) {
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
      this.comment, 
      this.description, 
      this.marketName, 
      this.status, 
      this.amountTotal, 
      this.boughtAt, 
      this.createdAt, 
      this.operator, 
      this.inn, 
      this.userCheckNum, 
      this.shiftNumber, 
      this.goods,});

  Data.fromJson(dynamic json) {
    id = json['id'].toString()??'';
    comment = json['comment']?? '';
    description = json['description']?? '';
    marketName = json['market_name']?? '';
    status = json['status']?? '';
    amountTotal = json['amount_total'].toString()?? '';
    boughtAt = json['bought_at']?? '';
    createdAt = json['created_at']??'';
    operator = json['operator']??'';
    inn = json['inn'].toString()??'';
    userCheckNum = json['user_check_num'].toString()??'';
    shiftNumber = json['shift_number'].toString()??'';
    cashBack = json['cashback'].toString()??'';

    if (json['goods'] != null) {
      goods = [];
      json['goods'].forEach((v) {
        goods.add(Goods.fromJson(v));
      });
    }
  }
  String id;
  String comment;
  String description;
  String marketName;
  String status;
  String amountTotal;
  String boughtAt;
  String createdAt;
  String operator;
  String inn;
  String userCheckNum;
  String shiftNumber;
  String cashBack;
  List<Goods> goods;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['comment'] = comment;
    map['description'] = description;
    map['market_name'] = marketName;
    map['status'] = status;
    map['amount_total'] = amountTotal;
    map['bought_at'] = boughtAt;
    map['created_at'] = createdAt;
    map['operator'] = operator;
    map['inn'] = inn;
    map['user_check_num'] = userCheckNum;
    map['shift_number'] = shiftNumber;
    map['cashBack'] = cashBack;
    if (goods != null) {
      map['goods'] = goods.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Goods goodsFromJson(String str) => Goods.fromJson(json.decode(str));
String goodsToJson(Goods data) => json.encode(data.toJson());
class Goods {
  Goods({
      this.price, 
      this.name, 
      this.quantity, 
      this.sum, 
      this.calculateCashback, 
      this.comment, 
      this.type, 
      this.amount,});

  Goods.fromJson(dynamic json) {
    price = json['price'].toString()?? '';
    name = json['name']??'';
    quantity = json['quantity'].toString()??'';
    sum = json['sum'].toString()??'';
    calculateCashback = json['cashback'].toString()??'';
    comment = json['comment']??'';
    type = json['type']??'';
    amount = json['amount'] ?? 0;
  }
  String price;
  String name;
  String quantity;
  String sum;
  String calculateCashback;
  String comment;
  dynamic type;
  dynamic amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['price'] = price;
    map['name'] = name;
    map['quantity'] = quantity;
    map['sum'] = sum;
    map['calculate_cashback'] = calculateCashback;
    map['comment'] = comment;
    map['type'] = type;
    map['amount'] = amount;
    return map;
  }

}

class ErrorRequestCheckInfo extends CheckInfoModel {
  final String error;

  ErrorRequestCheckInfo({
    this.error,
  });
}