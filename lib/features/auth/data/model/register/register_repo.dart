import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pick_up/config/end_points.dart';
import 'package:pick_up/core/user_model.dart';
import 'package:pick_up/handlers/shared_handler.dart';
import 'package:pick_up/network/web_services.dart';

class RegisterRepo{
    Future<UserModel> registerRequest(Map<String, dynamic> data) async {
    try {
      Response res = await Network.instance!.post(
          url: SharedHandler.instance!.getData(
                      key: SharedKeys().userType, valueType: ValueType.int) ==
                  0
              ? ApiNames.clientRegisterEndPoint
              : ApiNames.driverRegisterEndPoint,withToken: false,
          body: data);
      log('res.data: ${res.data}');
      return UserModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

}