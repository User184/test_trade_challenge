import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/auth/view/screens/reg_form.dart';
import 'package:teklub/tests/models/test_model.dart';

import '../../../app/theme.dart';
import '../../../home/controllers/home_controller.dart';
import 'tests_widget.dart';

class TestCaruselWidget extends StatelessWidget {
  final TestModel testModel;

  const TestCaruselWidget({Key key, this.testModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => RegScreen()));
            Get.put(HomeController()).currentPageChange('tests');
          },
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                CommonTextWidget(
                  text: 'Тесты и опросы',
                  size: 18,
                  color: kTextColor,
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        CarouselSlider(
          options: CarouselOptions(
              height: 290,
              enableInfiniteScroll: false,
              viewportFraction: 0.90,
              disableCenter: true),
          items: testModel.data == null
              ? []
              : testModel.data
                  .where((element) => element.canPassed == true)
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(right: 20),
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
      ],
    );
  }
}
