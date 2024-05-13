import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get_storage/get_storage.dart';
import 'package:teklub/auth/data/api_setting.dart';
import 'package:teklub/auth/models/permission_model4.dart';
import 'package:teklub/auth/view/screens/auth_screen.dart';
import 'package:teklub/home/views/screens/home_screen.dart';

import '../../../app/theme.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  GetStorage storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PermissionModel4>(
        future: ApiSetting.getPermissions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              backgroundColor: kGlobalBlack,
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            );
          }
          if (snapshot.hasError || snapshot.data is ErrorRequestPermission4) {
            return const KeyboardVisibilityProvider(
              child: AuthScreen(),
            );
          }
          if (snapshot.hasData && snapshot.data is PermissionModel4) {
            PermissionModel4 model = snapshot.data;
            GetStorage mailSave = GetStorage();
            mailSave.write(
                'feedBackMail', model.data.company.feedbackEmail ?? '');

            return const HomeScreen();
          } else {
            return Center(
                child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const KeyboardVisibilityProvider(
                      child: AuthScreen(),
                    ),
                  ),
                );
              },
              child: const Text('Назад'),
            ));
          }
        });
  }
}
