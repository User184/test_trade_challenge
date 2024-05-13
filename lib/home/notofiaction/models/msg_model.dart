import 'dart:convert';
MsgModel msgModelFromJson(String str) => MsgModel.fromJson(json.decode(str));
String msgModelToJson(MsgModel data) => json.encode(data.toJson());

class MsgModel {
  MsgModel({
      this.data, 
      this.links, 
      this.meta,});

  MsgModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
  List<Data> data;
  Links links;
  Meta meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data.map((v) => v.toJson()).toList();
    }
    if (links != null) {
      map['links'] = links.toJson();
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
      this.currentPage, 
      this.from, 
      this.lastPage, 
      this.links, 
      this.path, 
      this.perPage, 
      this.to, 
      this.total,});

  Meta.fromJson(dynamic json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    if (json['links'] != null) {
      links = [];
      json['links'].forEach((v) {
        links.add(Links.fromJson(v));
      });
    }
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }
  int currentPage;
  int from;
  int lastPage;
  List<Links> links;
  String path;
  int perPage;
  int to;
  int total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = currentPage;
    map['from'] = from;
    map['last_page'] = lastPage;
    if (links != null) {
      map['links'] = links.map((v) => v.toJson()).toList();
    }
    map['path'] = path;
    map['per_page'] = perPage;
    map['to'] = to;
    map['total'] = total;
    return map;
  }

}

Links linksFromJson(String str) => Links.fromJson(json.decode(str));
String linksToJson(Links data) => json.encode(data.toJson());
class Links {
  Links({
      this.url, 
      this.label, 
      this.active,});

  Links.fromJson(dynamic json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }
  dynamic url;
  String label;
  bool active;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['label'] = label;
    map['active'] = active;
    return map;
  }

}


Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      this.id, 
      this.title, 
      this.content, 
      this.img, 
      this.createdAt, 
      this.read,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    img = json['img'];
    createdAt = json['created_at'];
    read = json['read'];
  }
  int id;
  String title;
  String content;
  String img;
  String createdAt;
  dynamic read;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['content'] = content;
    map['img'] = img;
    map['created_at'] = createdAt;
    map['read'] = read;
    return map;
  }

}

class ErrorRequestMsg extends MsgModel {
  final String error;

  ErrorRequestMsg({
    this.error,
  });
}
class SuccessMsg extends MsgModel {
  final String result;

  SuccessMsg({
    this.result,
  });
}