abstract class ActionsModelAbs {}

class ActionsModel extends ActionsModelAbs {
  ActionsModel({
    this.data,
  });
  List<DataActions> data;

  ActionsModel.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => DataActions.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class DataActions {
  DataActions({
    this.id,
    this.title,
    this.description,
    this.participants,
    this.active,
    this.dateStart,
    this.dateEnd,
    this.cover,
    this.coverMp,
    this.promotionTerms,
  });
  int id;
  String title;
  String description;
  Participants participants;
  bool active;
  String dateStart;
  String dateEnd;
  List<Cover> cover;
  Null coverMp;
  List<PromotionTerms> promotionTerms;

  DataActions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    participants = Participants.fromJson(json['participants']);
    active = json['active'];
    dateStart = json['date_start'];
    dateEnd = json['date_end'];
    cover = List.from(json['cover']).map((e) => Cover.fromJson(e)).toList();
    coverMp = null;
    promotionTerms = json["promotion_terms"] != null
        ? List.from(json["promotion_terms"])
            .map((e) => PromotionTerms.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['description'] = description;
    _data['participants'] = participants.toJson();
    _data['active'] = active;
    _data['date_start'] = dateStart;
    _data['date_end'] = dateEnd;
    _data['cover'] = cover.map((e) => e.toJson()).toList();
    _data['cover_mp'] = coverMp;
    _data['promotion_terms'] = promotionTerms;
    return _data;
  }
}

class Participants {
  Participants({
    this.segments,
    this.specializations,
  });
  List<String> segments;
  List<String> specializations;

  Participants.fromJson(Map<String, dynamic> json) {
    segments = List.castFrom<dynamic, String>(json['segments']);
    specializations = List.castFrom<dynamic, String>(json['specializations']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['segments'] = segments;
    _data['specializations'] = specializations;
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

  Cover.fromJson(Map<String, dynamic> json) {
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

class PromotionTerms {
  PromotionTerms({
    this.name,
    this.url,
  });
  String name;
  String url;

  PromotionTerms.fromJson(Map<String, dynamic> json) {
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

class ErrorRequestAction extends ActionsModelAbs {
  final String error;

  ErrorRequestAction({
    this.error,
  });
}
