import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pick_up/features/order/data/model/order_repo.dart';
import 'package:pick_up/features/order/data/model/send_order_model.dart';
import 'package:pick_up/routing/navigator.dart';
import 'package:pick_up/routing/routes.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<OrderClick>(sendOrder);
  }
  final SendOrderRepo _sendOrderRepo = SendOrderRepo();
  late SendOrderModel _sendOrderModel;
  String truckType = '';
  String shipmentType = '';
  String shipmentDescription = '';
  String shipmentLat = '';
  String shipmentLong = '';
  String deliveryLat = '';
  String deliveryLong = '';
  List<File> images = [];
  String price = '';
  String km = '';
  String isLoadShipmentAvilabel = '';
  String isExtraManAvilabel = '';
  String isElevatorAvilabel = '';
  String pickUpFloor = '';
  String deleviryFloor = '';
  String created = '';
  String clientSecret = '';
///////////////////////////////////////
  /*  int orderCar = -1;
    int carIndex = -1;
    int orderType = -1;
    TextEditingController orderDescriptionController = TextEditingController();
    int orderHolder = -1;
    TextEditingController orderRecieveFloorController = TextEditingController();
    TextEditingController orderSendFloorController = TextEditingController();
    int oredrElevetor = -1;
    int orderAdditionalWorker = -1;
    List orderImages = [];
    String orderRecieveLocation = '';
    String orderSendLocation = ''; */
  /* int paymentType = -1;
    int orderStatus = -1;
    int orderPrice = -1;
    int orderDate = -1;
    int orderTime = -1; */
  sendOrder(OrderEvent events, Emitter emit) async {
    emit(OrderLoading());
    try {
      Map<String, dynamic> data = {
        "truckType": truckType,
        "shipmentType": shipmentType,
        "shipmentDescription": shipmentDescription,
        "shipmentLat": shipmentLat,
        "shipmentLong": shipmentLong,
        "deliveryLat": deliveryLat,
        "deliveryLong": deliveryLong,
        "price": price,
        // To Do : check loop for images
        "images":images,
        "km": km,
        "isLoadShipmentAvilabel": isLoadShipmentAvilabel,
        "isExtraManAvilabel": isExtraManAvilabel,
        "isElevatorAvilabel": isElevatorAvilabel,
        "pickUpFloor": pickUpFloor,
        "deleviryFloor": deleviryFloor,
        "created": created,
        "clientSecret": clientSecret,
      };
      _sendOrderModel = await _sendOrderRepo.sendOrderRequest(data);

      AppRoutes.pushNamedNavigator(
        routeName: Routes.payment, /*  replacement: true */
      );
      emit(OrderLoaded());
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }
}
