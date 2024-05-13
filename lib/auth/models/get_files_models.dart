import 'dart:convert';

GetFilesModels getFilesModelsFromJson(String str) =>
    GetFilesModels.fromJson(json.decode(str));

String getFilesModelsToJson(GetFilesModels data) => json.encode(data.toJson());

class GetFilesModels {
  GetFilesModels({
    this.data,
  });

  GetFilesModels.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(DataGetFilesModels.fromJson(v));
      });
    }
  }

  List<DataGetFilesModels> data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

DataGetFilesModels dataFromJson(String str) =>
    DataGetFilesModels.fromJson(json.decode(str));

String dataToJson(DataGetFilesModels data) => json.encode(data.toJson());

class DataGetFilesModels {
  DataGetFilesModels({
    this.type,
    this.url,
  });

  DataGetFilesModels.fromJson(dynamic json) {
    type = json['type'];
    url = json['url'];
  }

  String type;
  String url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['url'] = url;
    return map;
  }
}

class FaqFileModel {
  final String url;
  final String type;

  FaqFileModel({this.url, this.type});
}

class ErrorRequestGetFiles extends GetFilesModels {
  final String error;

  ErrorRequestGetFiles({
    this.error,
  });
}
