import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:teklub/app/user/screens/user_settings_screen.dart';
import 'package:teklub/auth/onboarding_screen/screens/onboarding_screen.dart';
import 'package:teklub/auth/view/screens/auth_screen.dart';
import 'package:teklub/auth/view/screens/push_accept.dart';
import 'package:teklub/auth/view/screens/reg_form.dart';
import 'package:teklub/auth/view/screens/start_screen.dart';
import 'package:teklub/auth/view/screens/welcome_screen_loader.dart';
import 'package:teklub/home/views/screens/home_screen.dart';
import 'package:teklub/home/views/screens/money/get_money_screen.dart';
import 'package:teklub/home/views/screens/money/get_money_type_select_screen.dart';
import 'package:teklub/home/views/screens/nachislen/check_info_screen.dart';
import 'package:teklub/home/views/screens/nachislen/nachislenie_screen.dart';
import 'package:teklub/scanner/views/screens/hand_check_add.dart';
import 'package:teklub/scanner/views/screens/mechanic_screen.dart';
import 'package:teklub/scanner/views/screens/scanner_screen.dart';

import '../../action/view/screens/action_screen.dart';
import '../../home/views/screens/money/add_sertificate_unit.dart';
import '../../tests/views/screens/end_test_ screen.dart';

const String startScreen = 'startScreen';
const String welcomeScreen = 'welcomeScreen';
const String onBoardingScreen = 'onBoarding';
const String authScreen = 'authScreen';
const String regScreen = 'regScreen';
const String userSettingsScreen = 'userSettingsScreen';
const String pushAcceptScreen = 'pushAcceptScreen';
const String homeScreen = 'homeScreen';
const String nachislenieScreen = 'nachislenieScreen';
const String getMoneyScreen = 'getMoneyScreen';
const String getScanScreen = 'getScanScreen';
const String actionScreen = 'ActionScreen';
const String getMechanicScreen = 'getMechanicScreen';
const String getHandCheckAddScreen = 'getHandCheckAddScreen';
const String checkInfoScreen = 'checkInfoScreen';
const String moneyGetSelectTypeScreen = 'moneyGetSelectTypeScreen';
const String endTestScreen = 'endTestScreen';

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case onBoardingScreen:
      return MaterialPageRoute(
        builder: (context) => const OnBoardingScreen(),
      );
    case authScreen:
      return MaterialPageRoute(
        builder: (context) => const KeyboardVisibilityProvider(
          child: AuthScreen(),
        ),
      );
    case 'AddSerticateUnitScreen':
      return MaterialPageRoute(
          builder: (_) =>
              AddSerticateUnitScreen(list_sert: settings.arguments));
    case regScreen:
      return MaterialPageRoute(
        builder: (context) => const KeyboardVisibilityProvider(
          child: RegScreen(),
        ),
      );
    case userSettingsScreen:
      return MaterialPageRoute(
        builder: (context) => const KeyboardVisibilityProvider(
          child: UserSettingsScreen(),
        ),
      );
    case pushAcceptScreen:
      return MaterialPageRoute(
        builder: (context) => const PushAcceptScreen(),
      );
    case homeScreen:
      return MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );

    case nachislenieScreen:
      return MaterialPageRoute(
        builder: (context) => const NachislenieScreen(),
      );
    case getMoneyScreen:
      return MaterialPageRoute(
        builder: (context) => GetMoneyScreen(),
      );

    case startScreen:
      return MaterialPageRoute(
        builder: (context) => const StartScreen(),
      );
    case welcomeScreen:
      return MaterialPageRoute(
        builder: (context) => const WelcomeScreenLoader(),
      );
    case getScanScreen:
      return MaterialPageRoute(
        builder: (context) => const ScannerScreen(),
      );
    case actionScreen:
      return MaterialPageRoute(
        builder: (context) => const ActionScreen(),
      );
    case getMechanicScreen:
      return MaterialPageRoute(
        builder: (context) => const MechanicScreen(),
      );
    case getHandCheckAddScreen:
      return MaterialPageRoute(
        builder: (context) => const HandCheckAddScreen(),
      );
    case checkInfoScreen:
      return MaterialPageRoute(
        builder: (context) => const CheckInfoScreen(),
      );
    case moneyGetSelectTypeScreen:
      return MaterialPageRoute(
        builder: (context) => const GetMoneySelectTypeScreen(),
      );
    case endTestScreen:
      return MaterialPageRoute(
        builder: (context) => const EndTestScreen(),
      );
    default:
      throw ('bad rout');
  }
}
