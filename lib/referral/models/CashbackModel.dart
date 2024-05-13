
abstract class AbsCashbackModel{}


class CashbackModel extends AbsCashbackModel{
  CashbackModel({
     this.data,
  });
   Data data;

  CashbackModel.fromJson(Map<String, dynamic> json){
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
     this.code,
     this.active,
     this.type,
     this.name,
     this.description,
     this.startDate,
     this.endDate,
     this.referralPoints,
     this.checksSum,
     this.cover,
  });
   String code;
   bool active;
   String type;
   String name;
   String description;
   String startDate;
   String endDate;
   int referralPoints;
   int checksSum;
   List<Cover> cover;

  Data.fromJson(Map<String, dynamic> json){
    code = json['code'];
    active = json['active'];
    type = json['type'];
    name = json['name'];
    description = json['description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    referralPoints = json['referral_points'];
    checksSum = json['checks_sum'];
    cover = List.from(json['cover']).map((e)=>Cover.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['active'] = active;
    _data['type'] = type;
    _data['name'] = name;
    _data['description'] = description;
    _data['start_date'] = startDate;
    _data['end_date'] = endDate;
    _data['referral_points'] = referralPoints;
    _data['checks_sum'] = checksSum;
    _data['cover'] = cover.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Cover {
  Cover({
     this.name,
     this.url,
  });
   String name;
   String url;

  Cover.fromJson(Map<String, dynamic> json){
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['url'] = url;
    return _data;
  }
}

class ErrorRequestCashback extends AbsCashbackModel {
  final String error;

  ErrorRequestCashback(
      {
        this.error,
      });
}
