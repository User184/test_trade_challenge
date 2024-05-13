import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fcm/Notification/FCM.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get_storage/get_storage.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/auth/controller/settings_controller.dart';
import 'package:teklub/auth/data/api_service.dart';

import '../../../app/theme.dart';
import '../../../home/views/screens/home_screen.dart';
import '/app/routes/route.dart' as route;

class Messaging {
  static String token;

  static initFCM() async {
    try {
      await FCM.initializeFCM(
          onNotificationPressed: (Map<String, dynamic> data) {
            print(data);
          },
          onTokenChanged: (String token) {
            GetStorage storage = GetStorage();
            Messaging.token = token;
            print('FCM - $token');
            APIServiceAuth.updateFcmToken(token);
            storage.write('fcmToken', token);
          },
          icon: '@drawable/fcmicon');
    } catch (e) {
      print(e);
    }
  }
}

class PushAcceptScreen extends StatefulWidget {
  const PushAcceptScreen({Key key}) : super(key: key);

  @override
  State<PushAcceptScreen> createState() => _PushAcceptScreenState();
}

class _PushAcceptScreenState extends State<PushAcceptScreen> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    var WIDTH = MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: GetBuilder<SettingsController>(
          init: SettingsController(),
          autoRemove: false,
          builder: (controller) {
            return Scaffold(
              backgroundColor: kGlobalBlack,
              body: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.05),
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Image.asset(
                            'assets/images/ballball.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50, right: 20),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(
                                Colors.white.withOpacity(0.1))),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(
                                isFirst: true,
                              ),
                            ),
                          );
                        },
                        child: const CommonTextWidget(
                          text: 'Пропустить',
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        const Spacer(),
                        const CommonTextWidget(
                          text: 'Уведомления',
                          fontWeight: FontWeight.w700,
                          size: 24,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: CommonTextWidget(
                            text:
                                'Разрешите приложению отправлять вам push-уведомления, чтобы быть в курсе последних событий',
                            size: 16,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 25,
                              bottom: MediaQuery.of(context).size.height * 0.05,
                              top: 5,
                              right: 25),
                          child: Material(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            color: const Color(0xffffffff),
                            child: InkWell(
                              onTap: () async {
                                Messaging.initFCM();

                                GetStorage store = GetStorage();
                                store.write('firstEnter', false);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomeScreen(
                                      isFirst: true,
                                    ),
                                  ),
                                );
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
                                        text: 'Разрешить',
                                        fontWeight: FontWeight.w700,
                                        size: 16,
                                        color: kGlobal,
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: kGlobal,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
