import 'dart:convert';
TestSend testSendFromJson(String str) => TestSend.fromJson(json.decode(str));
String testSendToJson(TestSend data) => json.encode(data.toJson());

class TestSend {
  TestSend({
      this.data,});

  TestSend.fromJson(dynamic json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data data;

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
      this.passed, 
      this.correctAnswers, 
      this.totalQuestions, 
      this.message, 
      this.points,});

  Data.fromJson(dynamic json) {
    passed = json['passed'];
    correctAnswers = json['correct_answers'];
    totalQuestions = json['total_questions'];
    message = json['message'];
    points = json['points'];
  }
  bool passed;
  int correctAnswers;
  int totalQuestions;
  String message;
  int points;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['passed'] = passed;
    map['correct_answers'] = correctAnswers;
    map['total_questions'] = totalQuestions;
    map['message'] = message;
    map['points'] = points;
    return map;
  }

}
class ErrorRequestTestSend extends TestSend {
  final String error;

  ErrorRequestTestSend({
    this.error,
  });
}