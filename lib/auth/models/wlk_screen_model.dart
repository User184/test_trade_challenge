import 'dart:convert';
WlkScreen wlkScreenFromJson(String str) => WlkScreen.fromJson(json.decode(str));
String wlkScreenToJson(WlkScreen data) => json.encode(data.toJson());

class WlkScreen {
  WlkScreen({
      this.data,});

  WlkScreen.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(DataWlkScreen.fromJson(v));
      });
    }
  }
  List<DataWlkScreen> data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

DataWlkScreen dataFromJson(String str) => DataWlkScreen.fromJson(json.decode(str));
String dataToJson(DataWlkScreen data) => json.encode(data.toJson());
class DataWlkScreen {
  DataWlkScreen({
      this.title, 
      this.text, 
      this.url,});

  DataWlkScreen.fromJson(dynamic json) {
    title = json['title'];
    text = json['text'];
    url = json['url'];
  }
  String title;
  String text;
  String url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['text'] = text;
    map['url'] = url;
    return map;
  }

}

class ErrorWlkScreen extends WlkScreen {
  final String error;

  ErrorWlkScreen({
    this.error,
  });
}
