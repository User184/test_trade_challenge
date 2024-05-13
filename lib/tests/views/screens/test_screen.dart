import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/tests/data/test_services.dart';
import 'package:teklub/tests/models/test_model.dart';
import 'package:teklub/tests/views/widgets/tests_widget.dart';

import '../../../app/theme.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xffF3F7FF),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<TestModel>(
              future: ApiServiceTest.getTests(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: CommonTextWidget(
                      text: 'Ошибка',
                      size: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.red,
                    ),
                  );
                }
                if (snapshot.hasData) {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: snapshot.data.data == null
                          ? const Center(
                              child: CommonTextWidget(
                                text: 'Ошибка',
                                size: 15,
                                color: Colors.redAccent,
                              ),
                            )
                          : snapshot.data.data.isEmpty
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          .2),
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/face_sad.svg',
                                          height: 72,
                                          color: const Color(0xffB51919),
                                        ),
                                        const SizedBox(
                                          height: 40,
                                        ),
                                        CommonTextWidget(
                                          text: 'Тестов и опросов нет!',
                                          color: ThemeSettings.primaryColorText,
                                          fontWeight: FontWeight.w400,
                                          textAlign: TextAlign.center,
                                          fontFamily: 'Arial',
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Column(
                                  children: snapshot.data.data
                                      .map(
                                        (e) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 8),
                                          child: TestsWidget(
                                            id: e.id,
                                            title: e.title,
                                            type: e.type,
                                            dateStart: e.dateStart,
                                            dateEnd: e.dateEnd,
                                            sumCost: e.sumCost,
                                            testCover: e.testCover,
                                            testMaterials: e.testMaterials,
                                            testPassed: e.testPassed,
                                            canPassed: e.canPassed,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                    ),
                  );
                }
                return Center(
                  heightFactor: MediaQuery.of(context).size.height * 0.02,
                  child: const CircularProgressIndicator(
                    color: kGlobal,
                  ),
                );
              }),
        ],
      ),
    );
  }
}
