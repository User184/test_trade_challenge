import 'dart:convert';
NewTest newTestFromJson(String str) => NewTest.fromJson(json.decode(str));
String newTestToJson(NewTest data) => json.encode(data.toJson());

class NewTest {
  NewTest({
      this.data,});

  NewTest.fromJson(dynamic json) {
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
      this.id, 
      this.title, 
      this.type, 
      this.youtubeUrl, 
      this.htmlDescription, 
      this.questions, 
      this.testCover, 
      this.testMaterials, 
      this.testPassed, 
      this.canPassed,
      this.viewers,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    youtubeUrl = json['youtube_url'];
    htmlDescription = json['html_description'];
    if (json['questions'] != null) {
      questions = [];
      json['questions'].forEach((v) {
        questions.add(Questions.fromJson(v));
      });
    }
    if (json['test_cover'] != null) {
      testCover = [];
      json['test_cover'].forEach((v) {
        testCover.add(TestCover.fromJson(v));
      });
    }
    if (json['test_materials'] != null) {
      testMaterials = [];
      json['test_materials'].forEach((v) {
        testMaterials.add(TestMaterials.fromJson(v));
      });
    }
    testPassed = json['test_passed'];
    canPassed = json['can_passed'];
    viewers = json['viewers'];
  }
  int id;
  String title;
  String type;
  String youtubeUrl;
  String htmlDescription;
  List<Questions> questions;
  List<TestCover> testCover;
  List<TestMaterials> testMaterials;
  bool testPassed;
  bool canPassed;
  int viewers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['type'] = type;
    map['youtube_url'] = youtubeUrl;
    map['html_description'] = htmlDescription;
    if (questions != null) {
      map['questions'] = questions.map((v) => v.toJson()).toList();
    }
    if (testCover != null) {
      map['test_cover'] = testCover.map((v) => v.toJson()).toList();
    }
    if (testMaterials != null) {
      map['test_materials'] = testMaterials.map((v) => v.toJson()).toList();
    }
    map['test_passed'] = testPassed;
    map['can_passed'] = canPassed;
    map['viewers'] = viewers;
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

Questions questionsFromJson(String str) => Questions.fromJson(json.decode(str));
String questionsToJson(Questions data) => json.encode(data.toJson());
class Questions {
  Questions({
      this.id, 
      this.testId, 
      this.title, 
      this.type, 
      this.correctAnswers, 
      this.answers, 
      this.questionImage,
      this.answerImagesCount,
  });

  Questions.fromJson(dynamic json) {
    id = json['id'];
    testId = json['test_id'];
    title = json['title'];
    type = json['type'];
    correctAnswers = json['correct_answers'];
    answerImagesCount = json['answer_images_count'];
    if (json['answers'] != null) {
      answers = [];
      json['answers'].forEach((v) {
        answers.add(Answers.fromJson(v));
      });
    }
    if (json['question_image'] != null) {
      questionImage = [];
      json['question_image'].forEach((v) {
        questionImage.add(QuestionImage.fromJson(v));
      });
    }
  }
  int id;
  int testId;
  String title;
  String type;
  int correctAnswers;
  List<Answers> answers;
  List<QuestionImage> questionImage;
  int answerImagesCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['test_id'] = testId;
    map['title'] = title;
    map['type'] = type;
    map['correct_answers'] = correctAnswers;
    map['answer_images_count'] = answerImagesCount;
    if (answers != null) {
      map['answers'] = answers.map((v) => v.toJson()).toList();
    }
    if (questionImage != null) {
      map['question_image'] = questionImage.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

QuestionImage questionImageFromJson(String str) => QuestionImage.fromJson(json.decode(str));
String questionImageToJson(QuestionImage data) => json.encode(data.toJson());
class QuestionImage {
  QuestionImage({
      this.name, 
      this.url,});

  QuestionImage.fromJson(dynamic json) {
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

Answers answersFromJson(String str) => Answers.fromJson(json.decode(str));
String answersToJson(Answers data) => json.encode(data.toJson());
class Answers {
  Answers({
      this.id, 
      this.questionId, 
      this.value, 
      this.correct, 
      this.answerImage,});

  Answers.fromJson(dynamic json) {
    id = json['id'];
    questionId = json['question_id'];
    value = json['value'];
    correct = json['correct'];
    answerImage = json['answer_image'];
  }
  int id;
  int questionId;
  String value;
  bool correct;
  dynamic answerImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['question_id'] = questionId;
    map['value'] = value;
    map['correct'] = correct;
    map['answer_image'] = answerImage;
    return map;
  }

}
class ErrorRequestNewTest extends NewTest {
  final String error;

  ErrorRequestNewTest({
    this.error,
  });
}