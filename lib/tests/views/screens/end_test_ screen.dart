import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/tests/controllers/test_controller.dart';

import '../../../home/controllers/home_controller.dart';
import '/app/routes/route.dart' as route;
import '../../../app/theme.dart';
import '../../models/test_send_model.dart';

class EndTestScreen extends StatefulWidget {
  final TestSend testModel;

  const EndTestScreen({Key key, this.testModel}) : super(key: key);

  @override
  State<EndTestScreen> createState() => _EndTestScreenState();
}

class _EndTestScreenState extends State<EndTestScreen> {
  ConfettiController _controllerTopCenter;

  TestController testController = Get.find();

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerTopCenter.play();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerTopCenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 262;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor:
            widget.testModel.data.passed == false ? kGlobal : Colors.white,
        body: widget.testModel.data.passed == false
            ? Container(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.only(top: 140, left: 10, right: 10),
                          child: CommonTextWidget(
                            textAlign: TextAlign.center,
                            text:
                                'К сожалению, в этот раз вы не набрали\nминимальное количество баллов для\n получения награды.',
                            size: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.h),
                          child: Align(
                            alignment: Alignment.center,
                            child: Stack(
                              children: [
                                SizedBox(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Color(0xffB51919),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CommonTextWidget(
                                          text:
                                              '${widget.testModel.data.correctAnswers} из ${widget.testModel.data.totalQuestions}',
                                          size: 23,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(height: 5),
                                        CommonTextWidget(
                                          text:
                                              '${(widget.testModel.data.correctAnswers / widget.testModel.data.totalQuestions * 100).toString().split('.').first}%',
                                          size: 14,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                    width: 170,
                                    height: 170,
                                  ),
                                  height: 200,
                                ),
                                Positioned(
                                  left: 5,
                                  top: 150,
                                  child: Container(
                                    height: 40,
                                    width: 160,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    child: Center(
                                        child: CommonTextWidget(
                                      text: testController
                                                  .newTest.value.data.type ==
                                              'test'
                                          ? 'Тест не пройден'
                                          : 'Опрос не пройден',
                                      size: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xffB51919),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 50, left: 50, right: 50),
                          child: CommonTextWidget(
                            textAlign: TextAlign.center,
                            text: widget.testModel.data.message,
                            size: 16,
                            fontFamily: 'Arial',
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 25,
                              bottom: MediaQuery.of(context).size.height * 0.05,
                              top: 5,
                              right: 25),
                          child: Material(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            color: Color(0xffF9F9F9),
                            child: InkWell(
                              onTap: () async {
                                Get.put(HomeController())
                                    .currentPageChange('tests');
                                testController.question.value = 0;
                                testController.questionNumber.clear();
                                testController.progressTestList.clear();
                                testController.testUpload.value = false;
                                Navigator.pushReplacementNamed(
                                    context, route.homeScreen);
                              },
                              child: SizedBox(
                                height: 70,
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      CommonTextWidget(
                                        text: 'Назад к списку тестов и опросов',
                                        fontWeight: FontWeight.w700,
                                        size: 16,
                                        color: kGlobal,
                                        fontFamily: 'Arial',
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: 10,
                          top: MediaQuery.of(context).size.height * 0.08),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[300]),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.close),
                              ),
                            ),
                            onTap: () {
                              Get.put(HomeController())
                                  .currentPageChange('tests');
                              testController.question.value = 0;
                              testController.questionNumber.clear();
                              testController.progressTestList.clear();
                              testController.testUpload.value = false;
                              Navigator.pushReplacementNamed(
                                  context, route.homeScreen);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Stack(
                alignment: Alignment.topCenter,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: ConfettiWidget(
                      confettiController: _controllerTopCenter,
                      blastDirectionality: BlastDirectionality.explosive,
                      // don't specify a direction, blast randomly
                      shouldLoop: true,
                      // start again as soon as the animation is finished
                      colors: const [
                        Colors.green,
                        Colors.blue,
                        Colors.pink,
                        Colors.orange,
                        Colors.purple
                      ],
                      // manually specify the colors to be used
                      createParticlePath:
                          drawStar, // define a custom shape/path.
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 30.h),
                        child: Align(
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              SizedBox(
                                child: CircularPercentIndicator(
                                  radius: 80.0,
                                  lineWidth: 10.0,
                                  percent: 1.0,
                                  center: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CommonTextWidget(
                                        text:
                                            '${widget.testModel.data.correctAnswers} из ${widget.testModel.data.totalQuestions}',
                                        size: 23,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xff292C31),
                                      ),
                                      const SizedBox(height: 5),
                                      CommonTextWidget(
                                        text:
                                            '${(widget.testModel.data.correctAnswers / widget.testModel.data.totalQuestions * 100).toString().split('.').first}%',
                                        size: 14,
                                        fontWeight: FontWeight.normal,
                                        color: const Color(0xff292C31),
                                      ),
                                    ],
                                  ),
                                  progressColor: const Color(0xff13971E),
                                ),
                                height: 200,
                              ),
                              Positioned(
                                left: 30,
                                top: 140,
                                child: Container(
                                  height: 50,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xff163c80d1),
                                        offset: Offset(0 * fem, 2 * fem),
                                        blurRadius: 2 * fem,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                      child: CommonTextWidget(
                                    text: '+ ${widget.testModel.data.points} б',
                                    size: 18,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xff13971E),
                                  )),
                                ),
                              ),
                              Positioned(
                                left: 60,
                                bottom: 155,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                    color: Color(0xff13971E),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 50, left: 50, right: 50),
                        child: CommonTextWidget(
                          textAlign: TextAlign.center,
                          text: widget.testModel.data.message,
                          size: 16,
                          fontWeight: FontWeight.normal,
                          color: const Color(0xff49536D),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 25,
                            bottom: MediaQuery.of(context).size.height * 0.02,
                            top: 5,
                            right: 25),
                        child: Material(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          color: Color(0xffF9F9F9),
                          child: InkWell(
                            onTap: () async {
                              Get.put(HomeController())
                                  .currentPageChange('main');
                              testController.question.value = 0;
                              testController.questionNumber.clear();
                              testController.progressTestList.clear();
                              testController.testUpload.value = false;

                              Navigator.pushReplacementNamed(
                                  context, route.homeScreen);
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
                                  children: const [
                                    CommonTextWidget(
                                      text: 'На главную',
                                      fontWeight: FontWeight.w700,
                                      size: 16,
                                      color: kGlobal,
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: kGlobal,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: 10,
                        top: MediaQuery.of(context).size.height * 0.08),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[300]),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.close),
                            ),
                          ),
                          onTap: () {
                            Get.put(HomeController()).currentPageChange('main');
                            testController.question.value = 0;
                            testController.questionNumber.clear();
                            testController.progressTestList.clear();
                            testController.testUpload.value = false;

                            Navigator.pushReplacementNamed(
                                context, route.homeScreen);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
