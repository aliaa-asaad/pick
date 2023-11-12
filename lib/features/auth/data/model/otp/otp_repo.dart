import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pick_up/config/end_points.dart';
import 'package:pick_up/features/auth/data/model/otp_model.dart';
import 'package:pick_up/network/web_services.dart';

class OTPRepo {
  Future<OTPModel> otpRequest(Map<String, dynamic> data) async {
    try {
      Response res = await Network.instance!.post(
          url: ApiNames.emailVerificationEndPoint,
          body: data,
          withToken: false);
      log('res.data: ${res.data}');
      return OTPModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }
}
