 import 'package:equatable/equatable.dart';

class  ProgressModel extends Equatable {
  final int testId;
  final int questionId;
  final int answerId;
  final bool correct;
  final String title;

  ProgressModel({
    this.testId,
    this.questionId,
    this.answerId,
    this.correct,
    this.title
  });

  @override
  // TODO: implement props
  List<Object> get props => [testId,questionId,answerId,correct,title];
}
