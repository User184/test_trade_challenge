import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teklub/home/views/screens/pdf_faq_screen.dart';
import 'package:teklub/tests/controllers/test_controller.dart';
import 'package:teklub/tests/data/test_services.dart';
import 'package:teklub/tests/models/new_test.dart';
import 'package:teklub/tests/views/screens/start_test_screen.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../app/common/components/common_text_widget.dart';
import '../../../app/theme.dart';

class NewTestScreen extends StatefulWidget {
  final int testId;
  final String type;
  final bool passed;

  const NewTestScreen({Key key, this.testId, this.type, this.passed})
      : super(key: key);

  @override
  State<NewTestScreen> createState() => _NewTestScreenState();
}

class _NewTestScreenState extends State<NewTestScreen> {
  final TestController testController =
      Get.put(TestController(), permanent: true);

  YoutubePlayerController _controller;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _controller.close();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: kGlobalBlack,
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey[300]),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Icon(Icons.arrow_back_ios),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                      future: ApiServiceTest.getNewTest(widget.testId),
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
                          NewTest test = snapshot.data;
                          testController.newTest.value = test;
                          testController.questionNumber.clear();
                          testController.getQuestionNumber();
                          if (test.data.youtubeUrl != null) {
                            List youTubeAddress =
                                test.data.youtubeUrl.split('/');
                            _controller = YoutubePlayerController(
                              initialVideoId: youTubeAddress.last,
                              params: const YoutubePlayerParams(
                                showControls: true,
                                showFullscreenButton: true,
                              ),
                            );
                          }
                          return ListView(
                            children: [
                              SizedBox(
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.fill,
                                        imageUrl: test.data.testCover != null
                                            ? test.data.testCover[0].url
                                            : '',
                                        placeholder: (context, url) =>
                                            const Center(
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
                                ),
                                width: 100.w,
                                height: 30.h,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    CommonTextWidget(
                                      text: test.data.title,
                                      size: 18,
                                      fontFamily: 'Arial',
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff49536D),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    CommonTextWidget(
                                      text:
                                          '${test.data.viewers.toString()} зрителей',
                                      size: 14,
                                      fontFamily: 'Arial',
                                      fontWeight: FontWeight.normal,
                                      color: const Color(0xff49536D),
                                    ),
                                    Html(
                                      data: test.data.htmlDescription,
                                    ),
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                              ),
                              if (test.data.testMaterials != null &&
                                  test.data.testMaterials.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 20),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (test.data.testMaterials != null &&
                                          test.data.testMaterials.isNotEmpty) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => PdfViewer(
                                              url: test
                                                  .data.testMaterials[0].url,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: Material(
                                      color: const Color(0xffF9F9F9),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 22),
                                        child: Row(
                                          children: [
                                            Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: kGlobal),
                                                width: 40,
                                                height: 40,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SvgPicture.asset(
                                                    'assets/images/pdf.svg',
                                                    color: Colors.white,
                                                  ),
                                                )),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            const CommonTextWidget(
                                              text: 'Изучите материалы',
                                              size: 14,
                                              fontFamily: 'Arial',
                                              color: Color(0xff49536D),
                                            ),
                                            const Spacer(),
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 20),
                                              child: Icon(
                                                Icons.file_download,
                                                color: Color(0xff8793B4),
                                              ),
                                            )
                                          ],
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              if (test.data.youtubeUrl != null)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: SizedBox(
                                      height: 200,
                                      child: YoutubePlayerIFrame(
                                        controller: _controller,
                                        aspectRatio: 16 / 9,
                                      ),
                                    ),
                                  ),
                                ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 25,
                                    top: MediaQuery.of(context).size.height *
                                        0.16,
                                    right: 25),
                                child: Material(
                                  elevation: widget.passed == true ? 0 : 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  color: widget.passed == true
                                      ? Colors.grey
                                      : kGlobal,
                                  child: InkWell(
                                    onTap: widget.passed == true
                                        ? null
                                        : () {
                                            testController.progressTestList
                                                .clear();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    StartTestScreen(
                                                  testId: widget.testId,
                                                ),
                                              ),
                                            );
                                            if (_controller != null) {
                                              _controller.close();
                                            }
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
                                          children: [
                                            CommonTextWidget(
                                              text: widget.passed == true
                                                  ? widget.type != 'test'
                                                      ? 'Опрос пройден'
                                                      : 'Тест пройден'
                                                  : widget.type == 'test'
                                                      ? 'Пройти тест'
                                                      : 'Пройти опрос',
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Arial',
                                              size: 16,
                                            ),
                                            widget.passed == true
                                                ? const Icon(
                                                    Icons.block,
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
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(
                            color: kGlobal,
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
