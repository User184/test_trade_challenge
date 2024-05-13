import 'dart:convert';
SendMoneyPhone sendMoneyPhoneFromJson(String str) => SendMoneyPhone.fromJson(json.decode(str));
String sendMoneyPhoneToJson(SendMoneyPhone data) => json.encode(data.toJson());

class SendMoneyPhone {
  SendMoneyPhone({
      this.wallet, 
      this.phone, 
      this.amount, 
      this.type,});

  SendMoneyPhone.fromJson(dynamic json) {
    wallet = json['wallet'];
    phone = json['phone'];
    amount = json['amount'];
    type = json['type'];
  }
  String wallet;
  String phone;
  String amount;
  String type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['wallet'] = wallet;
    map['phone'] = phone;
    map['amount'] = amount;
    map['type'] = type;
    return map;
  }



}

class SuccessPhone extends SendMoneyPhone{
  final String success;

  SuccessPhone(this.success);

}

class ErrorRequestSendMoneyPhone extends SendMoneyPhone {
  final String error;

  ErrorRequestSendMoneyPhone({
    this.error,
  });
}