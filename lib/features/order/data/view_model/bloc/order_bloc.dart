import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pick_up/features/order/data/model/order_repo.dart';
import 'package:pick_up/features/order/data/model/send_order_model.dart';
import 'package:pick_up/routing/navigator.dart';
import 'package:pick_up/utilities/images.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    // on<OrderClick>(sendOrder);
  }
  static OrderBloc get instance =>
      BlocProvider.of(AppRoutes.navigatorState.currentContext!);
  final SendOrderRepo _sendOrderRepo = SendOrderRepo();
  late SendOrderModel _sendOrderModel;
  /*  String truckType = '';
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
  String clientSecret = ''; */

/////////////////////////////////////////////
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int currentStep = 0;
  int carIndex = -1;
  List<Map<String, dynamic>> carCardData = [
    {
      'image': AppImages.car1,
      'title': 'بيك أب',
      'length': '2 متر - 3 متر',
      'weight': '1 طن',
    },
    {
      'image': AppImages.car2,
      'title': 'دينة شبك',
      'length': '5 متر - 7 متر',
      'weight': '2 طن',
    },
    {
      'image': AppImages.car3,
      'title': 'دينة',
      'length': '2 متر - 3 متر',
      'weight': '2 طن',
    },
  ];
  int orderTypeIndex = -1;
  List<String> orderTypeData = [
    'أثاث منزلي',
    'اجهزة كهربائية',
    'مواشي وحيوانات',
    'مواد بناء وديكور',
  ];
  TextEditingController orderDescriptionController = TextEditingController();
  int orderDetailsTypeIndex = -1;

  List<String> orderDetailsTypeData = [
    'مطلوبة',
    'غير مطلوبة',
  ];
  TextEditingController orderRecieveFloorController = TextEditingController();
  TextEditingController orderSendFloorController = TextEditingController();
  List<String> additionalService = [
    'متوفر',
    'غير متوفر',
  ];
  int additionalServiceIndex1 = -1;
  int additionalServiceIndex2 = -1;
  TextEditingController orderRecieveLocationController =
      TextEditingController();
  TextEditingController orderSendLocationController = TextEditingController();
  List<File> imagesList = [];
  bool isValidData() {
    log('carIndex:$carIndex');
    log('orderTypeIndex:$orderTypeIndex');
    log('orderDescriptionController.text.isNotEmpty :${orderDescriptionController.text.isNotEmpty}');
    log('orderDetailsTypeIndex1:$orderDetailsTypeIndex');
    log('orderRecieveFloorController.text.isNotEmpty :${orderRecieveFloorController.text.isNotEmpty}');
    log('orderSendFloorController.text.isNotEmpty :${orderSendFloorController.text.isNotEmpty}');
    log('additionalServiceIndex1:$additionalServiceIndex1');
    log('additionalServiceIndex2:$additionalServiceIndex2');

    return carIndex != -1 &&
        orderTypeIndex != -1 &&
        orderDescriptionController.text.isNotEmpty &&
        orderDetailsTypeIndex != -1 &&
        orderRecieveFloorController.text.isNotEmpty &&
        orderSendFloorController.text.isNotEmpty &&
        additionalServiceIndex1 != -1 &&
        additionalServiceIndex2 != -1;
  }

  bool isValidLocation() {
    log('orderRecieveLocationController.text.isNotEmpty :${orderRecieveLocationController.text.isNotEmpty}');
    log('orderSendLocationController.text.isNotEmpty :${orderSendLocationController.text.isNotEmpty}');

    return orderRecieveLocationController.text.isNotEmpty &&
        orderSendLocationController.text.isNotEmpty;
  }

  bool isValidImages() {
    log('imagesList.isNotEmpty :${imagesList.isNotEmpty}');

    return imagesList.isNotEmpty;
  }

  void viewCounter({required bool back}) {
    if (back == true) {
      log('back');
      currentStep - 2;
       emit(OrderCounter());
    } else {
      currentStep++;
    }
    emit(OrderCounter());
  }
  /*  int orderCar = -1;
    int carIndex = -1;
    int orderType = -1;
    
    int orderHolder = -1;
    
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
  /*  sendOrder(OrderEvent events, Emitter emit) async {
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
        "images": images,
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
 */
}
