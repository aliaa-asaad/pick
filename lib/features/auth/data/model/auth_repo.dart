import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pick_up/config/end_points.dart';
import 'package:pick_up/core/user_model.dart';
import 'package:pick_up/features/auth/data/model/otp_model.dart';
import 'package:pick_up/features/auth/data/model/forget_password_model.dart';
import 'package:pick_up/network/web_services.dart';

class AuthRepo {
  /* Future<UserModel> loginRequest(Map<String, dynamic> data) async {
    try {
      Response res = await Network.instance!
          .post(url: ApiNames.loginEndPoint, body: data, withToken: false);
      log('res.data: ${res.data}');
      return UserModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  } */
/* 
  Future<UserModel> registerRequest(Map<String, dynamic> data) async {
    try {
      Response res = await Network.instance!.post(
          url: SharedHandler.instance!.getData(
                      key: SharedKeys().userType, valueType: ValueType.int) ==
                  0
              ? ApiNames.clientRegisterEndPoint
              : ApiNames.driverRegisterEndPoint,
          withToken: false,
          body: data);
      log('res.data: ${res.data}');
      return UserModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  } */

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

  Future<ForgetPasswordModel> forgetPasswordRequest(
      Map<String, dynamic> data) async {
    try {
      Response res = await Network.instance!.post(
          url: ApiNames.forgetPasswordEndPoint, body: data, withToken: false);
      log('res.data: ${res.data}');
      return ForgetPasswordModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> resetPasswordRequest(Map<String, dynamic> data) async {
    try {
      Response res = await Network.instance!.post(
          url: ApiNames.resetPasswordEndPoint, body: data, withToken: false);
      log('res.data: ${res.data}');
      return UserModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }
}
