import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get_storage/get_storage.dart';
import 'package:teklub/auth/data/api_setting.dart';
import 'package:teklub/auth/models/wlk_screen_model.dart';
import 'package:teklub/auth/onboarding_screen/screens/onboarding_screen.dart';
import 'package:teklub/auth/view/screens/auth_screen.dart';
import 'package:teklub/auth/view/screens/push_accept.dart';
import 'package:teklub/home/views/screens/home_screen.dart';

import '../../../app/theme.dart';

class WelcomeScreenLoader extends StatefulWidget {
  const WelcomeScreenLoader({Key key}) : super(key: key);

  @override
  State<WelcomeScreenLoader> createState() => _WelcomeScreenLoaderState();
}

class _WelcomeScreenLoaderState extends State<WelcomeScreenLoader> {
  GetStorage storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WlkScreen>(
        future: ApiSetting.getWelcomeScreens(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              backgroundColor: kGlobalBlack,
              body: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  color: kGlobal,
                ),
              ),
            );
          }
          if (snapshot.hasData) {
            if (snapshot.data is ErrorWlkScreen || snapshot.data == null) {
              return const KeyboardVisibilityProvider(child: AuthScreen());
            }
          }//9168314863

          if (snapshot.hasData && snapshot.data.data.isEmpty) {
            return storage.read('firstEnter') == true ||
                    storage.read('firstEnter') == null
                ? const PushAcceptScreen()
                : const HomeScreen();
          } else {
            print('start c welcome');
            return OnBoardingScreen(
              welcomeScreenModel: snapshot.data,
            );
          }
        });
  }
}
