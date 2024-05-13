import 'dart:convert';
TestModel testModelFromJson(String str) => TestModel.fromJson(json.decode(str));
String testModelToJson(TestModel data) => json.encode(data.toJson());

class TestModel {
  TestModel({
      this.data,});

  TestModel.fromJson(dynamic json) {
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
      this.id, 
      this.title, 
      this.type, 
      this.dateStart, 
      this.dateEnd, 
      this.sumCost, 
      this.testCover,
      this.testMaterials, 
      this.testPassed,
      this.canPassed,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    dateStart = json['date_start'];
    dateEnd = json['date_end'];
    sumCost = json['sum_cost'];
    testCover = json['test_cover'] != null ? TestCover.fromJson(json['test_cover']) : null;
    if (json['test_materials'] != null) {
      testMaterials = [];
      json['test_materials'].forEach((v) {
        testMaterials.add(TestMaterials.fromJson(v));
      });
    }
    testPassed = json['test_passed'];
    canPassed = json['can_passed'];
  }
  int id;
  String title;
  String type;
  String dateStart;
  String dateEnd;
  int sumCost;
  TestCover testCover;
  List<TestMaterials> testMaterials;
  bool testPassed;
  bool canPassed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['type'] = type;
    map['date_start'] = dateStart;
    map['date_end'] = dateEnd;
    map['sum_cost'] = sumCost;
    if (testCover != null) {
      map['test_cover'] = testCover.toJson();
    }
    if (testMaterials != null) {
      map['test_materials'] = testMaterials.map((v) => v.toJson()).toList();
    }
    map['test_passed'] = testPassed;
    map['can_passed'] = canPassed;
    return map;
  }

}

TestMaterials testMaterialsFromJson(String str) => TestMaterials.fromJson(json.decode(str));
String testMaterialsToJson(TestMaterials data) => json.encode(data.toJson());
class TestMaterials {
  TestMaterials({
      this.name, 
      this.url,});

  TestMaterials.fromJson(dynamic json) {
    name = json['name'];
    url = json['url'];
  }
  String name;
  String url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['url'] = url;
    return map;
  }

}

TestCover testCoverFromJson(String str) => TestCover.fromJson(json.decode(str));
  String testCoverToJson(TestCover data) => json.encode(data.toJson());
  class TestCover {
  TestCover({
  this.name,
  this.url,});

  TestCover.fromJson(dynamic json) {
  name = json['name'];
  url = json['url'];
  }
  String name;
  String url;

  Map<String, dynamic> toJson() {
  final map = <String, dynamic>{};
  map['name'] = name;
  map['url'] = url;
  return map;
  }

}
class ErrorRequestTests extends TestModel {
  final String error;

  ErrorRequestTests({
    this.error,
  });
}
