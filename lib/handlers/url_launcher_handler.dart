import 'dart:developer';
import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHandler {
  // Replace with the desired phone number

  static Future<void> openWhatsApp({required String phoneNumber}) async {
    String url = Platform.isAndroid
        ? "https://wa.me/$phoneNumber/}"
        : "https://api.whatsapp.com/send?phone=$phoneNumber";
    //Uri.parse("https://wa.me/$phoneNumber");
    try {
      if (await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication)) {
        
        
      }
    } catch (e) {
      log("Could not launch WhatsApp");
      log('error:$e');
      rethrow;
    }
  }
}
