
abstract class AbsReferralModel{}


class ReferralModel extends AbsReferralModel{
  ReferralModel({
    this.data,
  });

   List<DataReferralModel> data;

  factory ReferralModel.fromJson(Map<String, dynamic> json) {
    return ReferralModel(
        data: List.from(json['data']).map((e) => DataReferralModel.fromJson(e)).toList());
  }

  Map<String, dynamic> toJson() {
     final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class DataReferralModel {
  DataReferralModel({
    this.id,
    this.fio,
    this.phone,
    this.referralCode,
    this.sum,
    this.createdAt,
    this.referralBonus,
    this.referrerUser,
  });

   int id;
    String fio;
    String phone;
    String referralCode;
    double sum;
    String createdAt;
    bool referralBonus;
    ReferrerUser referrerUser;

  DataReferralModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fio = json['fio'];
    phone = json['phone'];
    referralCode = json['referral_code'];
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
    _data['referral_code'] = referralCode;
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
  });

    int id;
    String fio;
    String phone;

  ReferrerUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fio = json['fio'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
     final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['fio'] = fio;
    _data['phone'] = phone;
    return _data;
  }
}

class ErrorRequestReferral extends AbsReferralModel {
  final String error;

  ErrorRequestReferral(
       {
        this.error,
      });
}
