import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHandler {
  // Replace with the desired phone number

  static Future<void> openURL(
      {required String url}) async {
    try {
      if (await launchUrl(Uri.parse(url),
          mode: LaunchMode.externalApplication)) {}
    } catch (e) {
      log("Could not launch the website $url");
      log('error:$e');
      rethrow;
    }
  }
}
