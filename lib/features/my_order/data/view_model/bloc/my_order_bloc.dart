import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pick_up/features/my_order/data/model/all_orders_model.dart';
import 'package:pick_up/features/my_order/data/model/my_order_repo.dart';
import 'package:pick_up/features/my_order/data/model/order_details_model.dart';
import 'package:pick_up/features/my_order/data/model/order_status_model.dart';
import 'package:pick_up/features/my_order/data/view_model/bloc/my_order_event.dart';
import 'package:pick_up/routing/navigator.dart';

part 'my_order_state.dart';

class MyOrderBloc extends Bloc<MyOrderEvent, MyOrderState> {
  MyOrderBloc() : super(OrderStatusInitial()) {
    on<OrderStatusClick>(_postOrderStatus);
  }
  static MyOrderBloc get instance =>
      BlocProvider.of(AppRoutes.navigatorState.currentContext!);
  MyOrderRepo orderStatusRepo = MyOrderRepo();
  OrderStatusModel orderStatus = OrderStatusModel();
  int tabBarCurrentIndex = 0;
  List<Orders> allOrdersModel = [];
  int? orderId;
  OrderDetails orderDetailsModel = OrderDetails();

  /* int? orderId; */
  int? currentStep;
 
  getAllOrders() async {
    emit(MyOrderLoading());
    try {
      allOrdersModel = await orderStatusRepo.getAllOrders();
      log('all order cubit${allOrdersModel.toString()}');

      emit(MyOrderLoaded());
    } catch (e) {
      log('all order status error:${e.toString()}');

      emit(MyOrderError());
      rethrow;
    }
  }

  getOrderDetails(
      /* MyOrderEvent events, Emitter emit, */ {required int orderId}) async {
    emit(MyOrderLoading());
    try {
      orderDetailsModel =
          await orderStatusRepo.getOrderDetails(orderId: orderId);
      log('order details cubit${allOrdersModel.toString()}');

      emit(MyOrderLoaded());
    } catch (e) {
      log('order details error:${e.toString()}');

      emit(MyOrderError());
      rethrow;
    }
  }

  /*  getOrderDetails(OrderStatusClick events, Emitter emit,/* {required int orderId} */) async {
    emit(MyOrderLoading());
    try {
      orderDetailsModel =
          await orderStatusRepo.getOrderDetails(orderId:events.orderId);
      log('order details cubit${allOrdersModel.toString()}');

      emit(MyOrderLoaded());
    } catch (e) {
      log('order details error:${e.toString()}');

      emit(MyOrderError());
      rethrow;
    }
  } */

  _postOrderStatus(MyOrderEvent events, Emitter emit) async {
    emit(MyOrderLoading());
    try {
      Map<String, dynamic> data = {
        'order_id': orderId,
      };
      log('order id: ${orderId.toString()}');
      orderStatus = await orderStatusRepo.postOrderStatus(data);
      log('order status cubit${orderStatus.toString()}');
      log('order status ${orderStatus.status.toString()}');
      if (tabBarCurrentIndex == 0) {
        //Navigator.pop(AppRoutes.navigatorState.currentContext!);
      } else if (tabBarCurrentIndex == 2) {
        currentStep = orderStatus.status! - 3;
      }
      emit(MyOrderLoaded());
    } catch (e) {
      log('order status error:${e.toString()}');

      emit(MyOrderError());
      rethrow;
    }
  }
}
