import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pick_up/config/end_points.dart';
import 'package:pick_up/core/user_model.dart';
import 'package:pick_up/network/web_services.dart';

class LoginRepo{
   Future<UserModel> loginRequest(Map<String, dynamic> data) async {
    try {
      Response res = await Network.instance!
          .post(url: ApiNames.loginEndPoint, body: data, withToken: false);
      log('res.data: ${res.data}');
      return UserModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

}