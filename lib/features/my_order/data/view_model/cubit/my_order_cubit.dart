import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pick_up/features/my_order/data/model/my_order_repo.dart';
import 'package:pick_up/features/my_order/data/model/order_details_model.dart';
import 'package:pick_up/features/my_order/data/model/order_status_model.dart';
import 'package:pick_up/routing/navigator.dart';

part 'my_order_state.dart';

class MyOrderCubit extends Cubit<MyOrderState> {
  MyOrderCubit() : super(OrderStatusInitial());
  static MyOrderCubit get instance =>
      BlocProvider.of(AppRoutes.navigatorState.currentContext!);
  MyOrderRepo orderStatusRepo = MyOrderRepo();
  int tabBarCurrentIndex = 0;
  List<Orders> orderStatusModel = [];
  OrderDetails orderDetailsModel = OrderDetails();
  int? orderId;
  getOrderStatus() async {
    emit(MyOrderLoading());
    try {
      orderStatusModel = await orderStatusRepo.getOrderStatus();
      log('order status cubit${orderStatusModel.toString()}');

      emit(MyOrderLoaded());
    } catch (e) {
      log('order status error:${e.toString()}');

      emit(MyOrderError());
      rethrow;
    }
  }

  getOrderDetails({required int orderId}) async {
    emit(MyOrderLoading());
    try {
      orderDetailsModel = await orderStatusRepo.getOrderdetails(orderId: orderId);
      log('order details cubit${orderStatusModel.toString()}');

      emit(MyOrderLoaded());
    } catch (e) {
      log('order details error:${e.toString()}');

      emit(MyOrderError());
      rethrow;
    }
  }
}
