import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pick_up/config/end_points.dart';
import 'package:pick_up/core/user_model.dart';


import 'package:pick_up/network/web_services.dart';

class LoginRepo {
  /* final Network _pickupNetwork = Network(); */
  /* Future<dynamic> login({required String email, required String password}) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    body['mobilePhone'] = email;
    body['password'] = password;
    final response = await _pickupNetwork.post(url: ApiNames.baseUrl, body: body);
    return response;
  } */
  Future<UserModel> loginRequest(Map<String, dynamic> data) async {
    try {
      Response res = await Network.instance!.post(
          url: ApiNames.loginEndPoint, body: data);
          log('res.data: ${res.data}');
      return UserModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }
  
}
