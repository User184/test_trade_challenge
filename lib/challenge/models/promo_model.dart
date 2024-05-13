import 'dart:convert';

PromoModel promoModelFromJson(String str) =>
    PromoModel.fromJson(json.decode(str));

String promoModelToJson(PromoModel data) => json.encode(data.toJson());

class PromoModel {
  PromoModel({
    this.data,
  });

  PromoModel.fromJson(dynamic json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data data;
  PromoModel copyWith({
    Data data,
  }) =>
      PromoModel(
        data: data ?? this.data,
      );
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
    this.code,
    this.active,
    this.type,
    this.name,
    this.description,
    this.startDate,
    this.endDate,
    this.cover,
    this.results,
  });

  Data.fromJson(dynamic json) {
    code = json['code'] ?? '';
    active = json['active'];
    type = json['type'] ?? '';
    name = json['name'] ?? '';
    description = json['description'] ?? '';
    startDate = json['start_date'] ?? '';
    endDate = json['end_date'] ?? "";
    if (json['cover'] != null) {
      cover = [];
      json['cover'].forEach((v) {
        cover.add(Cover.fromJson(v));
      });
    }
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results.add(Results.fromJson(v));
      });
    }
  }
  String code;
  bool active;
  String type;
  String name;
  String description;
  String startDate;
  String endDate;
  List<Cover> cover;
  List<Results> results;
  Data copyWith({
    String code,
    bool active,
    String type,
    String name,
    String description,
    String startDate,
    String endDate,
    List<Cover> cover,
    List<Results> results,
  }) =>
      Data(
        code: code ?? this.code,
        active: active ?? this.active,
        type: type ?? this.type,
        name: name ?? this.name,
        description: description ?? this.description,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        cover: cover ?? this.cover,
        results: results ?? this.results,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['active'] = active;
    map['type'] = type;
    map['name'] = name;
    map['description'] = description;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    if (cover != null) {
      map['cover'] = cover.map((v) => v.toJson()).toList();
    }
    if (results != null) {
      map['results'] = results.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Results resultsFromJson(String str) => Results.fromJson(json.decode(str));
String resultsToJson(Results data) => json.encode(data.toJson());

class Results {
  Results({
    this.result,
    this.type,
    this.points,
  });

  Results.fromJson(dynamic json) {
    result = json['result'];
    type = json['type'];
    points = json['points'];
  }
  int result;
  int points;
  String type;
  Results copyWith({
    int result,
    int points,
    String type,
  }) =>
      Results(
        result: result ?? this.result,
        type: type ?? this.type,
        points: points ?? this.points,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['result'] = result;
    map['type'] = type;
    map['points'] = points;
    return map;
  }
}

Cover coverFromJson(String str) => Cover.fromJson(json.decode(str));
String coverToJson(Cover data) => json.encode(data.toJson());

class Cover {
  Cover({
    this.name,
    this.url,
  });

  Cover.fromJson(dynamic json) {
    name = json['name'];
    url = json['url'];
  }
  String name;
  String url;
  Cover copyWith({
    String name,
    String url,
  }) =>
      Cover(
        name: name ?? this.name,
        url: url ?? this.url,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['url'] = url;
    return map;
  }
}

class SuccessPromoDetail extends PromoModel {
  final String message;

  SuccessPromoDetail(this.message);
}

class ErrorPromoDetail extends PromoModel {
  final String message;

  ErrorPromoDetail(this.message);
}
