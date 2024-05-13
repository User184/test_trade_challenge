import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../app/common/components/common_text_widget.dart';
import '../../../app/theme.dart';
import '../../models/test_model.dart';
import '../screens/new_test_screen.dart';

class TestsWidget extends StatelessWidget {
  final int id;
  final String title;
  final String type;
  final String dateStart;
  final String dateEnd;
  final int sumCost;
  final TestCover testCover;
  final List<TestMaterials> testMaterials;
  final bool testPassed;
  final bool canPassed;
  final Function button;

  const TestsWidget(
      {Key key,
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
      this.button})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double baseWidth = 262;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(12 * fem),
          boxShadow: [
            BoxShadow(
              color: const Color(0x140025c2),
              offset: Offset(0 * fem, 2 * fem),
              blurRadius: 2 * fem,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: CommonTextWidget(
                text: 'Тесты и опросы',
                color: kTextColor,
                size: 24,
                fontFamily: 'Arial',
                fontWeight: FontWeight.w400,
              ),
            ),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.2,
                  foregroundDecoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Color(0xff1D1D1D).withOpacity(0.7),
                      ],
                    ),
                  ),
                  decoration: testCover != null
                      ? BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12.0)),
                          image: DecorationImage(
                            image: NetworkImage(testCover.url),
                            fit: BoxFit.cover,
                          ),
                        )
                      : null,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Container(
                      width: testPassed == true ? 150 : 90,
                      height: 30,
                      decoration: BoxDecoration(
                        color: testPassed == true ? Colors.white : kGlobal,
                        borderRadius: BorderRadius.circular(45),
                      ),
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            testPassed == true
                                ? type == 'test'
                                    ? 'Тест пройден'
                                    : 'Опрос пройден'
                                : '+$sumCost',
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.sp,
                                      fontFamily: 'Arial',
                                      color: testPassed == true
                                          ? kGlobal
                                          : const Color(0xffffffff),
                                    ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${DateFormat('dd-MM-yyyy').format(DateTime.parse(dateStart))} - ${DateFormat('dd-MM-yyyy').format(DateTime.parse(dateEnd))}',
                            style: Theme.of(context).textTheme.button.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Arial',
                                  fontSize: 14,
                                  color: const Color(0xffffffff),
                                ),
                          ),
                          Text(
                            title,
                            style: Theme.of(context).textTheme.button.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.sp,
                                  fontFamily: 'Arial',
                                  color: const Color(0xffffffff),
                                ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 30,
                bottom: canPassed == false ? 10 : 10,
                right: 30,
                top: 10,
              ),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    testPassed == false ? Color(0xff13971E) : kGlobal,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewTestScreen(
                        testId: id,
                        type: type,
                        passed: testPassed,
                      ),
                    ),
                  );
                },
                child: Text(
                  canPassed == false
                      ? 'Посмотреть'
                      : testPassed == true
                          ? type == 'test'
                              ? 'Тест пройден'
                              : 'Опрос пройден'
                          : type == 'test'
                              ? 'Пройти тест'
                              : 'Пройти опрос',
                  style: Theme.of(context).textTheme.button.copyWith(
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Arial',
                        fontSize: 14.sp,
                        color: const Color(0xffffffff),
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
