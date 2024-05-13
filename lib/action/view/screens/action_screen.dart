import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../app/common/components/common_text_widget.dart';
import '../../../app/theme.dart';
import '../../controllers/actions_controller.dart';
import '../../data/api_service_action.dart';
import '../../models/actions_model.dart';
import '../widgets/card_action_widget.dart';

class ActionScreen extends StatelessWidget {
  const ActionScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: FutureBuilder<ActionsModelAbs>(
          future: ApiServiceAction.getAction(),
          builder: (context, snapshot) {
            // print(snapshot.data);
            if (snapshot.hasData) {
              final ActionsModel actionsModel = snapshot.data as ActionsModel;
              print(actionsModel.data);
              return actionsModel.data.isNotEmpty
                  ? GetBuilder<ActionsController>(
                      init: ActionsController(),
                      builder: (controller) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CommonTextWidget(
                            text: 'Акции',
                            size: 24,
                            fontFamily: 'Arial',
                            fontWeight: FontWeight.w700,
                            color: Color(0xff49536D),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.756,
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) => CardActionWidget(
                                data: actionsModel.data[index],
                              ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 10,
                              ),
                              itemCount: actionsModel.data.length,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .2),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/face_sad.svg',
                              height: 72,
                              color: const Color(0xffB51919),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CommonTextWidget(
                                  text: 'Нет активных акций',
                                  color: ThemeSettings.primaryColorText,
                                  fontWeight: FontWeight.w400,
                                  textAlign: TextAlign.center,
                                  fontFamily: 'Arial',
                                  size: 18,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                CommonTextWidget(
                                  text: 'Ожидается в ближайшее время.',
                                  color: ThemeSettings.primaryColorText,
                                  fontWeight: FontWeight.w400,
                                  textAlign: TextAlign.center,
                                  size: 16,
                                  fontFamily: 'Arial',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
            }
            return const Center(
              child: CircularProgressIndicator(
                color: kGlobal,
              ),
            );
          }),
    );
  }
}
