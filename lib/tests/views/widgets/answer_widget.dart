import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/app/theme.dart';
import 'package:teklub/tests/controllers/test_controller.dart';

class AnswerWidget extends StatefulWidget {
  final int answerId;
  final String title;
  final String type;
  final bool correct;
  final int questionId;

  const AnswerWidget(
      {Key key,
      this.answerId,
      this.title,
      this.correct,
      this.questionId,
      this.type})
      : super(key: key);

  @override
  State<AnswerWidget> createState() => _AnswerWidgetState();
}

class _AnswerWidgetState extends State<AnswerWidget> {
  TestController testController = Get.find();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 262;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0x140025c2),
                offset: Offset(0 * fem, 2 * fem),
                blurRadius: 2 * fem,
              ),
            ],
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            color: testController.done.value == true
                ? widget.type == 'survey'
                    ? testController.progressTest.contains(widget.answerId)
                        ? const Color(0xff13971E)
                        : testController.progressTest
                                    .contains(widget.answerId) &&
                                !widget.correct
                            ? Color(0xffB51919)
                            : Color(0xffF9F9F9)
                    : widget.correct == true
                        ? const Color(0xff13971E)
                        : testController.progressTest.contains(widget.answerId)
                            ? const Color(0xffB51919)
                            : const Color(0xffF9F9F9)
                : testController.progressTest.contains(widget.answerId)
                    ? kGlobal
                    : testController.progressTest.contains(widget.answerId) &&
                            !widget.correct
                        ? const Color(0xff13971E)
                        : const Color(0xffF9F9F9),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: CommonTextWidget(
                  text: widget.title,
                  size: 18,
                  color:
                      testController.progressTest.contains(widget.answerId) ||
                              (testController.done.value == true &&
                                  widget.correct == true)
                          ? Colors.white
                          : const Color(0xff49536D)),
            ),
          ),
          width: double.infinity,
          height: 70,
        ),
      );
    });
  }
}
