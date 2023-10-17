import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pick_up/config/end_points.dart';
import 'package:pick_up/core/email_verification_model.dart';
import 'package:pick_up/core/user_model.dart';
import 'package:pick_up/handlers/shared_handler.dart';
import 'package:pick_up/network/web_services.dart';

class RegisterRepo {
  /* final Network _pickupNetwork = Network(); */

  /* Future<AuthModel> registerRequest(Map<String, dynamic> data) async {
    try {
      Response res = await Network.instance!.post(
        url: ApiNames.baseUrl + ApiNames.registerEndPoint,
        body: data,
      );

      return AuthModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  } */

  Future<UserModel> registerRequest(Map<String, dynamic> data) async {
    try {
      Response res = await Network.instance!.post(
          url: SharedHandler.instance!.getData(
                      key: SharedKeys().userType, valueType: ValueType.int) ==
                  0
              ? ApiNames.clientRegisterEndPoint
              : ApiNames.driverRegisterEndPoint,
          body: data);
      log('res.data: ${res.data}');
      return UserModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<EmailVerifiactionModel> emailVerificationRequest(
      Map<String, dynamic> data) async {
    try {
      Response res = await Network.instance!
          .post(url: ApiNames.emailVerificationEndPoint, body: data);
      log('res.data: ${res.data}');
      return EmailVerifiactionModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  /* Future<DriverRegisterModel> driverClientRequest(
      Map<String, dynamic> data) async {
    try {
      Response res = await Network.instance!
          .post(url: ApiNames.driverRegisterEndPoint, body: data);
      log('res.data: ${res.data}');
      return DriverRegisterModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  } */
}
