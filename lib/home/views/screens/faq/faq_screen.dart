import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/home/controllers/home_controller.dart';
import 'package:teklub/home/models/api_models/faq_model.dart';
import 'package:teklub/home/views/screens/faq/faq_text_screen.dart';
import 'package:teklub/home/views/widgets/faq_widgets/faq_file_widget.dart';
import 'package:teklub/home/views/widgets/home_mane_widgets/any_quastion_widget.dart';

import '../../../../app/theme.dart';
import '../../../../auth/models/get_files_models.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kGlobalBlack,
        body: FutureBuilder(
          future: Future.wait([
            controller.getFaqData(),
            controller.getFaqFiles(),
          ]),
          builder: (context, snapshot) {
            if (snapshot.data is ErrorRequestFaq) {
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.4),
                child: const Center(
                  child: CommonTextWidget(
                    text: 'Ошибка. Нет сети',
                    fontWeight: FontWeight.w700,
                    color: Colors.deepOrange,
                    size: 20,
                  ),
                ),
              );
            }
            if (snapshot.hasData) {
              List list = snapshot.data[1] as List<FaqFileModel>;

              return SlidingUpPanel(
                controller: controller.panelController,
                parallaxEnabled: true,
                parallaxOffset: .5,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(30)),
                maxHeight: MediaQuery.of(context).size.height * 0.9,
                minHeight: MediaQuery.of(context).size.height * 0.35,
                panel: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0, bottom: 20),
                        child: Center(
                          child: Container(
                            width: 50,
                            height: 8,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(40),
                              ),
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            if (snapshot.data[0] == null ||
                                snapshot.data[0].isEmpty)
                              Center(
                                child: CommonTextWidget(
                                  text: 'Список пуст',
                                  size: 20,
                                  color: Colors.grey[300],
                                ),
                              ),
                            if (snapshot.data[0] != null ||
                                snapshot.data[0].isNotEmpty)
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: snapshot.data[0]
                                    .map<Widget>(
                                      (e) => ListTile(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FaqTextScreen(
                                                text: e.text,
                                                title: e.title,
                                              ),
                                            ),
                                          );
                                        },
                                        title: CommonTextWidget(
                                          text: e.title,
                                          size: 16,
                                          color: const Color(0xff49536D),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Arial',
                                        ),
                                        trailing:
                                            const Icon(Icons.arrow_forward_ios),
                                      ),
                                    )
                                    .toList(),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                body: list == null || list.isEmpty
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: Column(
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(top: 100),
                              child: Center(
                                child: CommonTextWidget(
                                  text: 'Документов нет',
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: ListView(children: [
                          ...snapshot.data[1]
                              .map<Widget>(
                                (e) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 5),
                                  child: FaqFileWidget(
                                    type: e.type,
                                    url: e.url,
                                  ),
                                ),
                              )
                              .toList(),
                          InkWell(
                            onTap: () {
                              AppMetrica.reportEvent(
                                'faq',
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 5),
                              child: AnyQuestionWidget(
                                colors: true,
                              ),
                            ),
                          ),
                        ]),
                      ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                color: kGlobal,
              ),
            );
          },
        ),
      );
    });
  }
}
