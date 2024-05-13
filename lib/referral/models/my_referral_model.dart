abstract class AbsMyReferralModel{}




class MyReferralModel extends AbsMyReferralModel {
  MyReferralModel({
     this.data,
  });
  List<Data> data;

  MyReferralModel.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
     this.id,
     this.fio,
     this.phone,
     this.sum,
     this.createdAt,
     this.referralBonus,
     this.referrerUser,
  });
  int id;
  String fio;
  String phone;
  String sum;
  String createdAt;
  bool referralBonus;
  ReferrerUser referrerUser;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    fio = json['fio'];
    phone = json['phone'];
    sum = json['sum'];
    createdAt = json['created_at'];
    referralBonus = json['referral_bonus'];
    referrerUser = ReferrerUser.fromJson(json['referrer_user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['fio'] = fio;
    _data['phone'] = phone;
    _data['sum'] = sum;
    _data['created_at'] = createdAt;
    _data['referral_bonus'] = referralBonus;
    _data['referrer_user'] = referrerUser.toJson();
    return _data;
  }
}

class ReferrerUser {
  ReferrerUser({
     this.id,
     this.fio,
     this.phone,
     this.referralCode,
  });
  int id;
  String fio;
  String phone;
  String referralCode;

  ReferrerUser.fromJson(Map<String, dynamic> json){
    id = json['id'];
    fio = json['fio'];
    phone = json['phone'];
    referralCode = json['referral_code'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['fio'] = fio;
    _data['phone'] = phone;
    _data['referral_code'] = referralCode;
    return _data;
  }
}

class ErrorRequestMyReferral extends AbsMyReferralModel {
  final String error;

  ErrorRequestMyReferral(
      {
        this.error,
      });
}
