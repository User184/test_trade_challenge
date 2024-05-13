import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/app/common/components/snack_bar.dart';
import 'package:teklub/tests/controllers/test_controller.dart';
import 'package:teklub/tests/data/test_services.dart';
import 'package:teklub/tests/models/test_send_model.dart';
import 'package:teklub/tests/views/screens/end_test_ screen.dart';
import 'package:teklub/tests/views/widgets/answer_widget.dart';

import '../../../app/theme.dart';
import '../../models/test_model.dart';
import '../widgets/pic_question_widget.dart';

class StartTestScreen extends StatefulWidget {
  final int testId;

  const StartTestScreen({Key key, this.testId}) : super(key: key);

  @override
  State<StartTestScreen> createState() => _StartTestScreenState();
}

class _StartTestScreenState extends State<StartTestScreen> {
  final TestController testController = Get.find();

  int answerChosen;
  var currentQuestion;

  int count = 0;

  var last;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    count = (testController.newTest.value.data.questions.length * 2);
    print(count);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGlobalBlack,
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LinearPercentIndicator(
                    linearStrokeCap: LinearStrokeCap.round,
                    backgroundColor: Colors.white,
                    width: 80.w,
                    barRadius: Radius.circular(20),
                    lineHeight: 12,
                    percent: testController.question.value /
                        testController.newTest.value.data.questions.length,
                    progressColor: kGlobal,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey[300]),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Padding(
                            padding: EdgeInsets.only(left: 0),
                            child: Icon(Icons.close),
                          ),
                        ),
                      ),
                      onTap: () {
                        testController.progressTestList.clear();
                        testController.progressTest.clear();
                        currentQuestion = null;
                        testController.question.value = 0;
                        testController.done.value = false;
                        testController.done.value = false;
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: CommonTextWidget(
                          text:
                              '${testController.question.value + 1} из ${testController.newTest.value.data.questions.length.toString()}',
                          size: 14,
                          color: const Color(0xff8793B4),
                        ),
                      ),
                    ),
                    if (testController.newTest.value.data.questions
                            .firstWhere((element) =>
                                element.id ==
                                testController.questionNumber[
                                    testController.question.value])
                            .answerImagesCount <
                        4)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Center(
                          child: CommonTextWidget(
                            text: testController.newTest.value.data.questions ==
                                        null ||
                                    testController
                                        .newTest.value.data.questions.isEmpty
                                ? 'Ошибка'
                                : testController.newTest.value.data.questions
                                    .firstWhere((element) =>
                                        element.id ==
                                        testController.questionNumber[
                                            testController.question.value])
                                    .title
                                    .toString(),
                            size: 24,
                            fontFamily: 'Arial',
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff49536D),
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (testController.newTest.value.data.questions
                                .where((element) =>
                                    element.id ==
                                    testController.questionNumber[
                                        testController.question.value])
                                .toList()
                                .first
                                .questionImage !=
                            null &&
                        testController.newTest.value.data.questions
                                .firstWhere((element) =>
                                    element.id ==
                                    testController.questionNumber[
                                        testController.question.value])
                                .answerImagesCount <
                            4)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: CachedNetworkImage(
                            imageUrl: testController
                                        .newTest.value.data.questions
                                        .where((element) =>
                                            element.id ==
                                            testController.questionNumber[
                                                testController.question.value])
                                        .toList()
                                        .first
                                        .questionImage ==
                                    null
                                ? ''
                                : testController.newTest.value.data.questions
                                    .where((element) =>
                                        element.id ==
                                        testController.questionNumber[
                                            testController.question.value])
                                    .toList()
                                    .first
                                    .questionImage
                                    .first
                                    .url,
                            placeholder: (context, url) => const Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    if (testController.newTest.value.data.questions
                            .firstWhere((element) =>
                                element.id ==
                                testController.questionNumber[
                                    testController.question.value])
                            .answerImagesCount ==
                        4)
                      PicQuestionWidget(
                        answers: testController.newTest.value.data.questions
                            .firstWhere((element) =>
                                element.id ==
                                testController.questionNumber[
                                    testController.question.value])
                            .answers,
                        title: testController.newTest.value.data.questions
                            .firstWhere((element) =>
                                element.id ==
                                testController.questionNumber[
                                    testController.question.value])
                            .title
                            .toString(),
                      ),
                    if (testController.newTest.value.data.questions
                            .firstWhere((element) =>
                                element.id ==
                                testController.questionNumber[
                                    testController.question.value])
                            .answerImagesCount ==
                        4)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: CommonTextWidget(
                          text: 'Нажмите на карту,\n чтобы перевернуть',
                          size: 18,
                          color: Color(0xff8793B4),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    if (testController.newTest.value.data.questions
                            .firstWhere((element) =>
                                element.id ==
                                testController.questionNumber[
                                    testController.question.value])
                            .answerImagesCount <
                        4)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 0, right: 20),
                          child: ListView(
                            children: testController
                                .newTest.value.data.questions
                                .where((element) =>
                                    element.id ==
                                    testController.questionNumber[
                                        testController.question.value])
                                .toList()
                                .first
                                .answers
                                .map(
                                  (e) => GestureDetector(
                                    onTap: () {
                                      if (testController
                                              .newTest
                                              .value
                                              .data
                                              .questions[
                                                  testController.question.value]
                                              .type ==
                                          'single') {
                                        if (testController.done.value ==
                                            false) {
                                          currentQuestion = testController
                                              .progressTestList
                                              .where((el) =>
                                                  el['id'] == e.questionId);

                                          // testController.progressTestList
                                          //     .clear();
                                          testController.progressTest.clear();
                                          testController.progressTestList.add({
                                            "id": e.questionId,
                                            "answers": [e.id]
                                          });
                                          testController.progressTest.add(e.id);
                                          // testController.done.value = true;
                                        }
                                      } else {
                                        if (testController.done.value ==
                                            false) {
                                          if (testController.progressTest
                                              .contains(e.id)) {
                                            testController.progressTest
                                                .removeWhere((element) =>
                                                    element == e.id);

                                            testController.progressTestList[
                                                    testController.question
                                                        .value]['answers']
                                                .removeWhere((element) =>
                                                    element == e.id);
                                          } else {
                                            currentQuestion = testController
                                                .progressTestList
                                                .where((el) =>
                                                    el['id'] == e.questionId);

                                            if (currentQuestion.isNotEmpty) {
                                              if (!currentQuestion
                                                  .single['answers']
                                                  .contains(e.id)) {
                                                currentQuestion
                                                    .single['answers'] = [
                                                  ...currentQuestion
                                                      .single['answers'],
                                                  e.id
                                                ];
                                                testController.progressTest
                                                    .add(e.id);
                                              }
                                            } else {
                                              testController.progressTestList
                                                  .add({
                                                "id": e.questionId,
                                                "answers": [e.id]
                                              });
                                              testController.progressTest
                                                  .add(e.id);
                                            }
                                          }
                                        }
                                      }
                                    },
                                    child: AnswerWidget(
                                      answerId: e.id,
                                      title: e.value,
                                      correct: e.correct,
                                      questionId: e.questionId,
                                      type: testController
                                          .newTest.value.data.type,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 20,
                          bottom: MediaQuery.of(context).size.height * 0.02,
                          top: 5,
                          right: 25),
                      child: Material(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          color: kGlobal, //009FE3
                          child: InkWell(
                            onTap: testController.testUpload.value == true
                                ? null
                                : () async {
                                    if (testController.progressTest.isEmpty) {
                                      CustomSnackBar.badSnackBar(
                                          context, 'Выберите ответ');
                                    } else {
                                      print(
                                          '+++++++*******${testController.progressTestList}');
                                      count = count - 1;

                                      if (count == 0) {
                                        print('+++++++*******');
                                        testController.testUpload.value = true;
                                        testController.progressTest.clear();

                                        TestSend res =
                                            await ApiServiceTest.sendTest();

                                        if (res is ErrorRequestTests ||
                                            res.data == null) {
                                          testController.testUpload.value =
                                              false;
                                          CustomSnackBar.badSnackBar(
                                              context, 'Попробуйте еще');

                                          return;
                                        } else {
                                          testController.done.value = false;
                                          testController.progressTest.clear();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EndTestScreen(
                                                testModel: res,
                                              ),
                                            ),
                                          );
                                        }

                                        setState(() {});
                                      } else {
                                        print('11111!!!!!!******');

                                        int q = testController.newTest.value
                                                .data.questions.length +
                                            1;

                                        if (testController
                                                .progressTestList.length ==
                                            q) {
                                          testController.testUpload.value =
                                              true;
                                          testController.progressTest.clear();

                                          TestSend res =
                                              await ApiServiceTest.sendTest();

                                          if (res is ErrorRequestTests ||
                                              res.data == null) {
                                            testController.testUpload.value =
                                                false;
                                            CustomSnackBar.badSnackBar(
                                                context, 'Попробуйте еще');

                                            return;
                                          } else {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EndTestScreen(
                                                  testModel: res,
                                                ),
                                              ),
                                            );
                                          }

                                          setState(() {});
                                        } else {
                                          if (testController
                                                  .progressTestList.length >
                                              q) {
                                            print('22222!!!!!!******');
                                          } else {
                                            if (testController.done.value ==
                                                false) {
                                              testController.done.value = true;
                                              setState(() {});
                                            } else {
                                              if (testController.newTest.value
                                                      .data.questions
                                                      .firstWhere((element) =>
                                                          element.id ==
                                                          testController
                                                                  .questionNumber[
                                                              testController
                                                                  .question
                                                                  .value])
                                                      .answerImagesCount ==
                                                  4) {
                                                testController
                                                    .flipCardController
                                                    .toggleCard();
                                                testController.question.value++;
                                                testController.progressTest
                                                    .clear();
                                                testController.done.value =
                                                    false;
                                              } else {
                                                testController.question.value++;

                                                testController.progressTest
                                                    .clear();
                                                testController.done.value =
                                                    false;
                                              }
                                            }
                                            setState(() {});
                                          }
                                        }
                                      }
                                    }
                                  },
                            child: SizedBox(
                              height: 70,
                              width: double.infinity,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Obx(() {
                                      return CommonTextWidget(
                                        text: testController.done.value == false
                                            ? 'Ответить'
                                            : 'Далее',
                                        fontWeight: FontWeight.w700,
                                        size: 16,
                                      );
                                    }),
                                    testController.testUpload.value == true
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : const Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
