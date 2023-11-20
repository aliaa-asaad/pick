import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pick_up/config/end_points.dart';
import 'package:pick_up/features/chat/data/model/chat_model.dart';
import 'package:pick_up/handlers/shared_handler.dart';
import 'package:pick_up/network/web_services.dart';

class ChatRepo{
  Future<List<Chat>> getNotifications(
      ) async {
    /* try { */
    final Response res = await Network.instance!.get(
        url: SharedHandler.instance!.getData(
                    key: SharedKeys().userType, valueType: ValueType.int) ==
                0
            ? ApiNames.chatClientEndPoint
            : ApiNames.chatDriverEndPoint,
      );
    if (res.statusCode! >= 200 && res.statusCode! < 300) {
      if (res.data.isNotEmpty
      ) 
      {log('status 200');
      log('chat data: ${res.data.toString()}');
      return ChatModel.fromJson(res.data).chat!;}
      else{
        log('chat is empty');
        return [];
      }
    } else {
      log('get chat repo error:${res.data}');
      throw Exception('Failed to load data!');
    }
  }
}