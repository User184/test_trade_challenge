import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../auth/data/api_setting.dart';

class UrlLauncher {
  static Future launchEmail() async {
    if (Platform.isAndroid) {
      const url = 'mailto:tc@teklub.com?subject=Обращение';
      if (await canLaunch(url)) {
        await launch(url);
      }
    } else {
      const String _emailSubject = 'Обращение';
      final String _emailLaunchString =
          Uri.encodeFull('mailto:tc@teklub.com?subject=$_emailSubject');
      if (await canLaunch(_emailLaunchString)) {
        await launch(_emailLaunchString);
      }
    }
  }

  static Future launchFeedBackEmail() async {
    if (Platform.isAndroid) {
      GetStorage mailSave = GetStorage();
      String mailString;
      if (mailSave.read('feedBackMail') == null) {
        final res = await ApiSetting.getPermissions();
        mailString = res.data.company.feedbackEmail;
      }

      final mail = mailSave.read('feedBackMail') ?? mailString;
      final String _emailLaunchString =
          'mailto:tc@teklub.com?subject=Обращение';
      if (await canLaunch(_emailLaunchString)) {
        await launch(_emailLaunchString);
      }
    } else {
      GetStorage mailSave = GetStorage();
      String mailString;
      if (mailSave.read('feedBackMail') == null) {
        final res = await ApiSetting.getPermissions();
        mailString = res.data.company.feedbackEmail;
      }

      final mail = mailSave.read('feedBackMail') ?? mailString;
      const String _emailSubject = 'Обращение';
      final String _emailLaunchString =
          Uri.encodeFull('mailto:tc@teklub.com?subject=$_emailSubject');
      if (await canLaunch(_emailLaunchString)) {
        await launch(_emailLaunchString);
      }
    }
  }
}
