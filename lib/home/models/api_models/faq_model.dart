import 'dart:convert';
FaqModel faqModelFromJson(String str) => FaqModel.fromJson(json.decode(str));
String faqModelToJson(FaqModel data) => json.encode(data.toJson());



class FaqModel {
  FaqModel({
      this.data,});

  FaqModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
  }
  List<Data> data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
      this.title, 
      this.body,});

  Data.fromJson(dynamic json) {
    title = json['title'];
    body = json['body'];
  }
  String title;
  String body;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['body'] = body;
    return map;
  }

}

class FaqModelUi {
  final String title;
  final String text;

  FaqModelUi({this.title, this.text});

}

class ErrorRequestFaq extends FaqModel {
  final String error;

  ErrorRequestFaq({
    this.error,
  });
}