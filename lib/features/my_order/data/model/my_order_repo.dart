import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pick_up/config/end_points.dart';
import 'package:pick_up/features/my_order/data/model/all_orders_model.dart';
import 'package:pick_up/features/my_order/data/model/order_details_model.dart';
import 'package:pick_up/features/my_order/data/model/order_status_model.dart';
import 'package:pick_up/features/my_order/data/view_model/bloc/my_order_bloc.dart';
import 'package:pick_up/handlers/shared_handler.dart';
import 'package:pick_up/network/web_services.dart';

class MyOrderRepo {
  Future<List<Orders>> getAllOrders() async {
    final Response res = await Network.instance!.get(
        url: SharedHandler.instance!.getData(
                    key: SharedKeys().userType, valueType: ValueType.int) ==
                0
            ? MyOrderBloc.instance.tabBarCurrentIndex == 0
                ? ApiNames.orderClientPendingEndPoint
                : MyOrderBloc.instance.tabBarCurrentIndex == 1
                    ? ApiNames.orderClientAcceptedEndPoint
                    : ApiNames.orderClientCompletedEndPoint
            : MyOrderBloc.instance.tabBarCurrentIndex == 0
                ? ApiNames.orderDriverPendingEndPoint
                : MyOrderBloc.instance.tabBarCurrentIndex == 1
                    ? ApiNames.orderDriverAcceptedEndPoint
                    : ApiNames.orderDriverCompletedEndPoint);
    log('all orders repo data: ${res.data.toString()}');
    log('all orders repo datatype: ${res.data.runtimeType}');
    if (res.statusCode! >= 200 && res.statusCode! < 300) {
      log('all orders repo code:${res.statusCode}');
      if (res.data.isNotEmpty) {
        return AllOrdersModel.fromJson(res.data).orders!;
      } else {
        return [];
      }
    } else {
      log('send all orders repo error:${res.data}');
      throw Exception('Failed to load data!');
    }
  }

  Future<OrderDetails> getOrderDetails({required orderId}) async {
    final Response res = await Network.instance!
        .get(url: ApiNames.orderDetailsEndPoint + orderId.toString());
    log('order details repo data: ${res.data.toString()}');
    log('order details repo datatype: ${res.data.runtimeType}');
    if (res.statusCode! >= 200 && res.statusCode! < 300) {
      log('repo status code:${res.statusCode}');
      if (res.data.isNotEmpty
      ) {
        return OrderDetailsModel.fromJson(res.data).orderDetails!;
      } else {
        log('order details is empty');
        return OrderDetails();
      }
    } else {
      log('send order details repo error:${res.data}');
      throw Exception('Failed to load data!');
    }
  }

  Future<OrderStatusModel> postOrderStatus(Map<String, dynamic> body) async {
    final Response res = await Network.instance!
        .post(url: ApiNames.orderStatusEndPoint, body: body);
    log('order status repo data: ${res.data.toString()}');
    log('order status repo datatype: ${res.data.runtimeType}');
    if (res.statusCode! >= 200 && res.statusCode! < 300) {
      log('repo status code:${res.statusCode}');
      /* if (res.data.isNotEmpty) {
        return OrderStatusModel.fromJson(res.data);
      } else {
        log('order status is empty');
        return OrderStatusModel();
      } */
      if (res.data.isNotEmpty) {
        log('post order response code:${res.statusCode}');
        return OrderStatusModel.fromJson(res.data);
      } else {
        log('order status is empty');
        log('post order response code:${res.statusCode}');
        return OrderStatusModel();
      }
    } else {
      log('send order status repo error:${res.data}');
      throw Exception('Failed to load data!');
    }
  }
}
