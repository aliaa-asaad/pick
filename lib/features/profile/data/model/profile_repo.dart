import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pick_up/config/end_points.dart';
import 'package:pick_up/core/user_model.dart';
import 'package:pick_up/network/web_services.dart';

class ProfileRepo{
  Future<UserModel> editProfileRequest(Map<String, dynamic> data) async {
    try {
      Response res = await Network.instance!
          .post(url: ApiNames.editProfileEndPoint, body: data, withToken: true);
      log('res.data: ${res.data}');
      return UserModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }
  Future<UserModel> uploadImageRequest(FormData data) async {
    try {
      Response res = await Network.instance!
          .post(url: ApiNames.editProfileEndPoint, imageBody: data,
        isImageBody: true, withToken: true);
      log('res.data: ${res.data}');
      return UserModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }
}