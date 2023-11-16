import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pick_up/config/end_points.dart';
import 'package:pick_up/features/notification/data/model/notification_model.dart';
import 'package:pick_up/handlers/shared_handler.dart';
import 'package:pick_up/network/web_services.dart';

class NotificationRepo {
  Future<NotificationModel> getNotifications(
      ) async {
    /* try { */
    final Response res = await Network.instance!.get(
        url: SharedHandler.instance!.getData(
                    key: SharedKeys().userType, valueType: ValueType.int) ==
                0
            ? ApiNames.notificationClientEndPoint
            : ApiNames.notificationDriverEndPoint,
      );
    if (res.statusCode! >= 200 && res.statusCode! < 300) {
      if (res.data.isNotEmpty
      ) 
     { log('status 200');
      log('notification data: ${res.data.toString()}');
      return NotificationModel.fromJson(res.data);}
      else{
        log('notification is empty');
        return NotificationModel();
      }
    } else {
      log('get notification repo error:${res.data}');
      throw Exception('Failed to load data!');
    }
  }
}
