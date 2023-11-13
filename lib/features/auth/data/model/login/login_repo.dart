import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pick_up/config/end_points.dart';
import 'package:pick_up/core/driver_model.dart';
import 'package:pick_up/core/user_model.dart';
import 'package:pick_up/handlers/shared_handler.dart';
import 'package:pick_up/network/web_services.dart';

class LoginRepo {
  Future loginRequest(Map<String, dynamic> data) async {
    try {
      Response res = await Network.instance!
          .post(url: ApiNames.loginEndPoint, body: data, withToken: false);
      log('res.data: ${res.data}');
      if (SharedHandler.instance!
              .getData(key: SharedKeys().userType, valueType: ValueType.int) ==
          0) {
        return UserModel.fromJson(res.data);
      } else {
        return DriverModel.fromJson(res.data);
      }
    } catch (e) {
      rethrow;
    }
  }
}
