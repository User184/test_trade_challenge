import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/home/data/api_service_home.dart';
import 'package:teklub/home/models/api_models/nachisl_model.dart';
import 'package:teklub/home/views/widgets/nachislenie_widgets/nachislenie_widget.dart';

import '../../../../app/theme.dart';

class NachislenieScreen extends StatelessWidget {
  final NachislModel nachislModel;

  const NachislenieScreen({Key key, this.nachislModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          body: SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                              top: 15,
                            ),
                            child: SizedBox(
                              width: 35,
                              height: 35,
                              child: GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey[300]),
                                  child: const Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color: Color(0xff49536D),
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 4.5,
                          ),
                          const CommonTextWidget(
                            text: 'Начисления',
                            size: 18,
                            fontFamily: 'Arial',
                            color: Color(0xff49536D),
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                      Expanded(
                        child: FutureBuilder<NachislModel>(
                            future: ApiServiceHome.getNachislenie(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                const Center(
                                  child: CommonTextWidget(
                                    text: 'Ошибка, попробуйте позже',
                                    color: Colors.red,
                                    size: 18,
                                  ),
                                );
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return SingleChildScrollView(
                                  child: Column(
                                    children: snapshot.data.data
                                        .asMap() // Get the index of each element in the list
                                        .map(
                                          (index, e) {
                                            print("cccccccc${e.status}");
                                            return MapEntry(
                                              // Map the index to each NachislenieWidget instance
                                              index,
                                              NachislenieWidget(
                                                status: e.status,
                                                title: e.causer,
                                                date: e.createdAt,
                                                sum: e.amount,
                                                id: e.causerId,
                                                causer: e.causer,
                                                title2: e.title,
                                              ),
                                            );
                                          },
                                        )
                                        .values
                                        .toList(),
                                  ),
                                );
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator(
                                  color: kGlobal,
                                ));
                              }
                              return const Center();
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
