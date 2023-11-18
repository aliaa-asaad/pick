import 'dart:developer';
import 'dart:io';

import 'package:pick_up/handlers/shared_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsappHandlers {
  static Future<void> openWhatsApp({required String phoneNumber}) async {
    String countryCode = SharedHandler.instance!.getData(
                key: SharedKeys().countryType, valueType: ValueType.int) ==
            0
        ? '+20'
        : '+9665';
    String url = Platform.isAndroid
        ? "whatsapp://send?phone=$countryCode$phoneNumber"
        : "https://api.whatsapp.com/send?phone=$countryCode$phoneNumber";
    //Uri.parse("https://wa.me/$phoneNumber");
    try {
      if (await launchUrl(Uri.parse(url),
          mode: LaunchMode.externalApplication)) {}
    } catch (e) {
      log("Could not launch WhatsApp");
      log('error:$e');
      rethrow;
    }
  }
}
