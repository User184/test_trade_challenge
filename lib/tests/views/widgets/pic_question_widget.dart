import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';

import '../../controllers/test_controller.dart';
import '../../models/new_test.dart';

class PicQuestionWidget extends StatefulWidget {
  final int answerId;
  final String picUrl;
  final String title;
  final bool correct;
  final int questionId;
  final List<Answers> answers;

  const PicQuestionWidget(
      {Key key,
      this.answerId,
      this.picUrl,
      this.title,
      this.correct,
      this.questionId,
      this.answers})
      : super(key: key);

  @override
  State<PicQuestionWidget> createState() => _PicQuestionWidgetState();
}

class _PicQuestionWidgetState extends State<PicQuestionWidget> {
  final TestController testController = Get.find();

  var currentQuestion;

  Color color;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.answers.forEach((element) {});
  }

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      controller: testController.flipCardController,
      fill: Fill.fillBack,
      // Fill the back side of the card to make in the same size as the front.
      direction: FlipDirection.HORIZONTAL,
      // default
      front: SizedBox(
        width: 100.w,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset('assets/images/sqwer.png'),
            CommonTextWidget(
              text: widget.title,
              size: 20,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      back: SizedBox(
        width: 100.w,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset('assets/images/sqwer.png'),
            Positioned(
              top: 25,
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (testController.done.value == false) {
                            if (testController.progressTest
                                .contains(widget.answers[0].id)) {
                              testController.progressTest.removeWhere(
                                  (element) => element == widget.answers[0].id);

                              testController.progressTestList[
                                      testController.question.value]['answers']
                                  .removeWhere((element) =>
                                      element == widget.answers[0].id);
                            } else {
                              currentQuestion = testController.progressTestList
                                  .where((el) =>
                                      el['id'] == widget.answers[0].questionId);

                              if (currentQuestion.isNotEmpty) {
                                if (!currentQuestion.single['answers']
                                    .contains(widget.answers[0].id)) {
                                  currentQuestion.single['answers'] = [
                                    ...currentQuestion.single['answers'],
                                    widget.answers[0].id
                                  ];
                                  testController.progressTest
                                      .add(widget.answers[0].id);
                                }
                              } else {
                                testController.progressTestList.add({
                                  "id": widget.answers[0].questionId,
                                  "answers": [widget.answers[0].id]
                                });
                                testController.progressTest
                                    .add(widget.answers[0].id);
                              }
                            }
                            setState(() {});
                          }
                        },
                        child: Stack(
                          children: [
                            SizedBox(
                              width: 40.w,
                              height: 40.w,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: testController.done.value == true
                                          ? widget.answers[0].correct == true
                                              ? const Color(0xff1FCED7)
                                              : Color(0xffB51919)
                                          : testController.progressTest
                                                  .contains(
                                                      widget.answers[0].id)
                                              ? const Color(0xff1FCED7)
                                              : testController.progressTest
                                                          .contains(widget
                                                              .answers[0].id) &&
                                                      !widget.answers[0].correct
                                                  ? Color(0xffB51919)
                                                  : Colors.transparent,
                                      width: 3),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8.0)),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    widget.answers[0].answerImage[0]['url'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            if (testController.done.value == true)
                              Container(
                                width: 40.w,
                                height: 40.w,
                                color: !widget.answers[0].correct
                                    ? Color(0xffB51919).withOpacity(0.5)
                                    : Colors.green.withOpacity(0.5),
                              )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (testController.done.value == false) {
                            if (testController.progressTest
                                .contains(widget.answers[1].id)) {
                              testController.progressTest.removeWhere(
                                  (element) => element == widget.answers[1].id);

                              testController.progressTestList[
                                      testController.question.value]['answers']
                                  .removeWhere((element) =>
                                      element == widget.answers[1].id);
                            } else {
                              currentQuestion = testController.progressTestList
                                  .where((el) =>
                                      el['id'] == widget.answers[1].questionId);

                              if (currentQuestion.isNotEmpty) {
                                if (!currentQuestion.single['answers']
                                    .contains(widget.answers[1].id)) {
                                  currentQuestion.single['answers'] = [
                                    ...currentQuestion.single['answers'],
                                    widget.answers[1].id
                                  ];
                                  testController.progressTest
                                      .add(widget.answers[1].id);
                                }
                              } else {
                                testController.progressTestList.add({
                                  "id": widget.answers[1].questionId,
                                  "answers": [widget.answers[1].id]
                                });
                                testController.progressTest
                                    .add(widget.answers[1].id);
                              }
                            }
                            setState(() {});
                          }
                        },
                        child: Stack(
                          children: [
                            SizedBox(
                              width: 40.w,
                              height: 40.w,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: testController.done.value == true
                                          ? widget.answers[1].correct == true
                                              ? const Color(0xff13971E)
                                              : Color(0xffB51919)
                                          : testController.progressTest
                                                  .contains(
                                                      widget.answers[1].id)
                                              ? const Color(0xff13971E)
                                              : testController.progressTest
                                                          .contains(widget
                                                              .answers[1].id) &&
                                                      !widget.answers[1].correct
                                                  ? Color(0xffB51919)
                                                  : Colors.transparent,
                                      width: 3),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8.0)),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    widget.answers[1].answerImage[0]['url'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            if (testController.done.value == true)
                              Container(
                                width: 40.w,
                                height: 40.w,
                                color: !widget.answers[1].correct
                                    ? Color(0xffB51919).withOpacity(0.5)
                                    : Colors.green.withOpacity(0.5),
                              )
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (testController.done.value == false) {
                            if (testController.progressTest
                                .contains(widget.answers[2].id)) {
                              testController.progressTest.removeWhere(
                                  (element) => element == widget.answers[2].id);

                              testController.progressTestList[
                                      testController.question.value]['answers']
                                  .removeWhere((element) =>
                                      element == widget.answers[2].id);
                            } else {
                              currentQuestion = testController.progressTestList
                                  .where((el) =>
                                      el['id'] == widget.answers[2].questionId);

                              if (currentQuestion.isNotEmpty) {
                                if (!currentQuestion.single['answers']
                                    .contains(widget.answers[2].id)) {
                                  currentQuestion.single['answers'] = [
                                    ...currentQuestion.single['answers'],
                                    widget.answers[2].id
                                  ];
                                  testController.progressTest
                                      .add(widget.answers[2].id);
                                }
                              } else {
                                testController.progressTestList.add({
                                  "id": widget.answers[2].questionId,
                                  "answers": [widget.answers[2].id]
                                });
                                testController.progressTest
                                    .add(widget.answers[2].id);
                              }
                            }
                            setState(() {});
                          }
                        },
                        child: Stack(
                          children: [
                            SizedBox(
                              width: 40.w,
                              height: 40.w,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: testController.done.value == true
                                          ? widget.answers[2].correct == true
                                              ? const Color(0xff13971E)
                                              : Color(0xffB51919)
                                          : testController.progressTest
                                                  .contains(
                                                      widget.answers[2].id)
                                              ? const Color(0xff13971E)
                                              : testController.progressTest
                                                          .contains(widget
                                                              .answers[2].id) &&
                                                      !widget.answers[2].correct
                                                  ? Color(0xffB51919)
                                                  : Colors.transparent,
                                      width: 3),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8.0)),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    widget.answers[2].answerImage[0]['url'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            if (testController.done.value == true)
                              Container(
                                width: 40.w,
                                height: 40.w,
                                color: !widget.answers[2].correct
                                    ? Color(0xffB51919).withOpacity(0.5)
                                    : Colors.green.withOpacity(0.5),
                              )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (testController.done.value == false) {
                            if (testController.progressTest
                                .contains(widget.answers[3].id)) {
                              testController.progressTest.removeWhere(
                                  (element) => element == widget.answers[3].id);

                              testController.progressTestList[
                                      testController.question.value]['answers']
                                  .removeWhere((element) =>
                                      element == widget.answers[3].id);
                            } else {
                              currentQuestion = testController.progressTestList
                                  .where((el) =>
                                      el['id'] == widget.answers[3].questionId);

                              if (currentQuestion.isNotEmpty) {
                                if (!currentQuestion.single['answers']
                                    .contains(widget.answers[3].id)) {
                                  currentQuestion.single['answers'] = [
                                    ...currentQuestion.single['answers'],
                                    widget.answers[3].id
                                  ];
                                  testController.progressTest
                                      .add(widget.answers[3].id);
                                }
                              } else {
                                testController.progressTestList.add({
                                  "id": widget.answers[3].questionId,
                                  "answers": [widget.answers[3].id]
                                });
                                testController.progressTest
                                    .add(widget.answers[3].id);
                              }
                            }
                            setState(() {});
                          }
                        },
                        child: Stack(
                          children: [
                            SizedBox(
                              width: 40.w,
                              height: 40.w,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: testController.done.value == true
                                          ? widget.answers[3].correct == true
                                              ? const Color(0xff13971E)
                                              : Color(0xffB51919)
                                          : testController.progressTest
                                                  .contains(
                                                      widget.answers[3].id)
                                              ? const Color(0xff13971E)
                                              : testController.progressTest
                                                          .contains(widget
                                                              .answers[3].id) &&
                                                      !widget.answers[3].correct
                                                  ? Color(0xffB51919)
                                                  : Colors.transparent,
                                      width: 3),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8.0)),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    widget.answers[3].answerImage[0]['url'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            if (testController.done.value == true)
                              Container(
                                width: 40.w,
                                height: 40.w,
                                color: !widget.answers[3].correct
                                    ? Color(0xffB51919).withOpacity(0.5)
                                    : Colors.green.withOpacity(0.5),
                              )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
    ;
  }
}
