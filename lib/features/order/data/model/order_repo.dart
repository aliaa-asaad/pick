import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pick_up/config/end_points.dart';
import 'package:pick_up/features/order/data/model/send_order_model.dart';
import 'package:pick_up/network/web_services.dart';

class SendOrderRepo {
  /* final Network _pickupNetwork = Network(); */

  Future<OrderDataModel> sendOrderRequest(Map<String, dynamic> data) async {
    /* try { */
    Response res = await Network.instance!
        .post(url: ApiNames.orderEndPoint, body: data, withToken: true);
    log('repo response ${res.data}');
    if (res.statusCode! >= 200 && res.statusCode! < 300) {
      return OrderDataModel.fromJson(res.data);
    } else {
      log('send order repo error:${res.data}');
      throw Exception('Failed to load data!');
    }
    /* } catch (e) {
      log('send order repo error:${e.toString()}');
      rethrow;
    } */
  }

  Future<OrderImagesDataModel> sendImagesRequest(FormData data) async {
    /* try { */
    Response res = await Network.instance!.post(
        url: ApiNames.orderImagesEndPoint,
        imageBody: data,
        isImageBody: true,
        );
    log('repo response ${res.data}');
    if (res.statusCode! >= 200 && res.statusCode! < 300) {
      log('status 200');
      return OrderImagesDataModel.fromJson(res.data);
    } else {
      log('send order images repo error:${res.data}');
      throw Exception('Failed to load data!');
    }
    /* } catch (e) {
      log('send order repo error:${e.toString()}');
      rethrow;
    } */
  }

  Future<OrderSubmitModel> sendSubmitRequest(Map<String, dynamic> data) async {
    /* try { */
    Response res = await Network.instance!
        .post(url: ApiNames.orderSubmitEndPoint, body: data, );
    log('repo response ${res.data}');
    if (res.statusCode! >= 200 && res.statusCode! < 300) {
      log('status 200');
      return OrderSubmitModel.fromJson(res.data);
    } else {
      log('send order submit repo error:${res.data}');
      throw Exception('Failed to load data!');
    }
    /* } catch (e) {
      log('send order repo error:${e.toString()}');
      rethrow;
    } */
  }
}
