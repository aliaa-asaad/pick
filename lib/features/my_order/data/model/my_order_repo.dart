import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pick_up/config/end_points.dart';
import 'package:pick_up/features/my_order/data/model/order_details_model.dart';
import 'package:pick_up/features/my_order/data/model/order_status_model.dart';
import 'package:pick_up/features/my_order/data/view_model/cubit/my_order_cubit.dart';
import 'package:pick_up/handlers/shared_handler.dart';
import 'package:pick_up/network/web_services.dart';

class MyOrderRepo {
  Future<List<Orders>> getOrderStatus() async {
    final Response res = await Network.instance!.get(
        url: SharedHandler.instance!.getData(
                    key: SharedKeys().userType, valueType: ValueType.int) ==
                0
            ? MyOrderCubit.instance.tabBarCurrentIndex == 0
                ? ApiNames.orderClientPendingEndPoint
                : ApiNames.orderClientFinishedEndPoint
            : MyOrderCubit.instance.tabBarCurrentIndex == 0
                ? ApiNames.orderDriverPendingEndPoint
                : ApiNames.orderDriverFinishingEndPoint);
    log('order status repo data: ${res.data.toString()}');
    log('order status repo datatype: ${res.data.runtimeType}');
    if (res.statusCode! >= 200 && res.statusCode! < 300) {
      log('repo status code:${res.statusCode}');
      if (res.data.isNotEmpty) {
        return OrderStatusModel.fromJson(res.data).orders!;
      } else {
        return [];
      }
    } else {
      log('send order status repo error:${res.data}');
      throw Exception('Failed to load data!');
    }
  }

  Future<OrderDetails> getOrderdetails({required orderId}) async {
    final Response res = await Network.instance!
        .get(url: ApiNames.orderDetailsEndPoint + orderId.toString());
    log('order status repo data: ${res.data.toString()}');
    log('order status repo datatype: ${res.data.runtimeType}');
    if (res.statusCode! >= 200 && res.statusCode! < 300) {
      log('repo status code:${res.statusCode}');
      if (res.data.isNotEmpty) {
        return OrderDetailsModel.fromJson(res.data).orderDetails!;
      } else {
        log('order details is empty');
        return OrderDetails();
      }
    } else {
      log('send order status repo error:${res.data}');
      throw Exception('Failed to load data!');
    }
  }
}
