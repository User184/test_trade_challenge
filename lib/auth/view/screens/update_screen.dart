import 'dart:io';

import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:teklub/app/theme.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/common/components/common_text_widget.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      gestures: const [
        GestureType.onVerticalDragDown,
        GestureType.onVerticalDragStart,
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kGlobalBlack,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: 120,
                  child: Image.asset('assets/images/logoblack.png'),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedPadding(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.only(top: 200),
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
                      const Padding(
                        padding: EdgeInsets.only(left: 29, right: 29, top: 41),
                        child: CommonTextWidget(
                          text:
                              'Уважаемые участники клуба K.PROFI! Уведомляем вас о том, что эта версия приложения устарела. Пожалуйста, установите последнюю версию из официальных магазинов App Store, Google Play и NashStore.',
                          fontWeight: FontWeight.w500,
                          size: 18,
                          height: 1.3,
                          textAlign: TextAlign.center,
                          color: Color(0xff8793B4),
                          fontFamily: 'Futura',
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 25,
                          bottom: MediaQuery.of(context).size.height * 0.05,
                          top: 5,
                          right: 25,
                        ),
                        child: Material(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          color: kGlobal,
                          child: InkWell(
                            onTap: () {
                              if (Platform.isAndroid || Platform.isIOS) {
                                final url = Uri.parse(
                                  Platform.isAndroid
                                      ? "https://play.google.com/store/apps/details?id=com.retail.tradechellenge"
                                      : "https://apps.apple.com/us/app/tchallenge/id6449224001",
                                );
                                launchUrl(
                                  url,
                                  mode: LaunchMode.externalApplication,
                                );
                              }
                            },
                            child: SizedBox(
                              height: 80,
                              width: double.infinity,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    CommonTextWidget(
                                      text: 'Далее',
                                      fontWeight: FontWeight.w700,
                                      size: 16,
                                    ),
                                    Icon(
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
