import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pick_up/config/end_points.dart';
import 'package:pick_up/core/driver_model.dart';
import 'package:pick_up/core/user_model.dart';
import 'package:pick_up/handlers/shared_handler.dart';
import 'package:pick_up/network/web_services.dart';

class RegisterRepo {
  Future registerRequest(Map<String, dynamic> data) async {
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
      if (SharedHandler.instance!
              .getData(key: SharedKeys().userType, valueType: ValueType.int) ==
          0) {
        return UserModel.fromJson(res.data);
      } else {
        log('driver repo: ${res.data}');
        log('driver model: ${DriverModel.fromJson(res.data)}');
        return DriverModel.fromJson(res.data);
      }
    } catch (e) {
      rethrow;
    }
  }
}
