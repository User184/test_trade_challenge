// import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'dart:io';

//import 'package:alice/alice.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:teklub/app/theme.dart';

import '/app/routes/route.dart' as route;
import 'app/common/initial_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpoverrides();
  await Firebase.initializeApp();
  await AppMetrica.activate(
      const AppMetricaConfig("67fbf52d-8242-40c9-bd53-44e9b8050aa2"));
  initializeDateFormatting('ru_RU');
  await GetStorage().initStorage;
  // await FlutterDownloader.initialize(debug: true);

  // Messaging.initFCM();
  await checkPermission();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  runApp(
    const App(),
  );
}

class MyHttpoverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> checkPermission() async {
  await [
    Permission.camera,
    Permission.storage,
    Permission.manageExternalStorage,
  ].request();
}

// Alice alice = Alice(
//   showInspectorOnShake: true,
//   showNotification: true,
// );

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Chuck chuck = Chuck(
    //   showNotification: true,
    //   showInspectorOnShake: true,
    //   darkTheme: false,
    //   maxCallsCount: 1000,
    // );
    // ApiReferral.getMyReferral();

    //alice.showInspector();

    return MediaQuery(
        data: MediaQueryData.fromWindow(WidgetsBinding.instance.window),
        // like this it works and produces correct font sizes
        child: Sizer(
          builder: (context, orientation, deviceType) {
            return GetMaterialApp(
              //navigatorKey: alice.getNavigatorKey(),
              initialBinding: InitialBinding(),
              debugShowCheckedModeBanner: false,
              title: 'TradeChallenge',
              theme: ThemeSettings().setTheme(),
              onGenerateRoute: route.controller,
              initialRoute: route.startScreen,
            );
          },
        ));
  }
}
