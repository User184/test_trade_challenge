import 'package:flip_card/flip_card_controller.dart';
import 'package:get/get.dart';
import 'package:teklub/tests/models/new_test.dart';

class TestController extends GetxController {
  RxBool testUpload = RxBool(false);

  FlipCardController flipCardController = FlipCardController();

  RxList progressTest = RxList([]);

  RxList<Map> progressTestList = RxList<Map>([]);

  Rx<NewTest> newTest = Rx<NewTest>(null);
  RxInt question = RxInt(0);

  RxBool done = RxBool(false);

  RxList questionNumber = RxList([]);

  getQuestionNumber() {
    for (var element in newTest.value.data.questions) {
      questionNumber.add(element.id);
    }
  }
}
