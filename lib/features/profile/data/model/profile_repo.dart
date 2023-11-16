import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pick_up/config/end_points.dart';
import 'package:pick_up/core/driver_model.dart';
import 'package:pick_up/core/user_model.dart';
import 'package:pick_up/features/profile/data/model/delete_account_model.dart';
import 'package:pick_up/handlers/shared_handler.dart';
import 'package:pick_up/network/web_services.dart';

class ProfileRepo {
  Future editProfileRequest(Map<String, dynamic> data) async {
    try {
      Response res = await Network.instance!.post(
          url: SharedHandler.instance!.getData(
                      key: SharedKeys().userType, valueType: ValueType.int) ==
                  0
              ? ApiNames.editProfileEndPoint
              : ApiNames.editDriverProfileEndPoint,
          body: data);
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

  Future uploadImageRequest(FormData data) async {
    try {
      Response res = await Network.instance!.post(
          url: SharedHandler.instance!.getData(
                      key: SharedKeys().userType, valueType: ValueType.int) ==
                  0
              ? ApiNames.editProfileEndPoint
              : ApiNames.editDriverProfileEndPoint,
          imageBody: data,
          isImageBody: true,
          withToken: true);
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

  Future<DeleteAccountModel> deleteProfileRequest() async {
    try {
      Response res = await Network.instance!.delete(
          url: SharedHandler.instance!.getData(
                      key: SharedKeys().userType, valueType: ValueType.int) ==
                  0
              ? ApiNames.deleteAccountClientEndPoint
              : ApiNames.deleteAccountDriverEndPoint);
      log('res.data: ${res.data}');

      return DeleteAccountModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }
}
