class CreditCard {
  CreditCard({
    this.cardNum,
    this.cardHolder,
    this.fio,
  });

  CreditCard.fromJson(dynamic json) {
    cardNum = json['cardNum'];
    cardHolder = json['cardHolder'];
    fio = json['fio'];
  }
  String cardNum;
  String cardHolder;
  String fio;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cardNum'] = cardNum;
    map['cardHolder'] = cardHolder;
    map['fio'] = fio;
    return map;
  }

}