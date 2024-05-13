import 'dart:convert';
SendMoneyCard sendMoneyCardFromJson(String str) => SendMoneyCard.fromJson(json.decode(str));
String sendMoneyCardToJson(SendMoneyCard data) => json.encode(data.toJson());

class SendMoneyCard {
  SendMoneyCard({
      this.wallet, 
      this.card, 
      this.fio, 
      this.cardHolderName, 
      this.amount, 
      this.type,});

  SendMoneyCard.fromJson(dynamic json) {
    wallet = json['wallet'];
    card = json['card'];
    fio = json['fio'];
    cardHolderName = json['card_holder_name'];
    amount = json['amount'];
    type = json['type'];
  }
  String wallet;
  String card;
  String fio;
  String cardHolderName;
  String amount;
  String type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['wallet'] = wallet;
    map['card'] = card;
    map['fio'] = fio;
    map['card_holder_name'] = cardHolderName;
    map['amount'] = amount;
    map['type'] = type;
    return map;
  }

}

class SuccessCard extends SendMoneyCard{
  final String success;

  SuccessCard(this.success);

}

class ErrorRequestSendMoneyCard extends SendMoneyCard {
  final String error;

  ErrorRequestSendMoneyCard({
    this.error,
  });
}