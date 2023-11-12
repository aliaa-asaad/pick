import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pick_up/features/order/data/model/order_repo.dart';
import 'package:pick_up/features/order/data/model/send_order_model.dart';
import 'package:pick_up/handlers/location_handler.dart';
import 'package:pick_up/routing/navigator.dart';
import 'package:pick_up/routing/routes.dart';
import 'package:pick_up/utilities/images.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<OrderDataClick>(_sendOrderData);
    on<OrderImagesClick>(_sendOrderImages);
    on<OrderSubmitClick>(_sendSubmitOrder);
  }
  static OrderBloc get instance =>
      BlocProvider.of(AppRoutes.navigatorState.currentContext!);
  final SendOrderRepo _sendOrderDataRepo = SendOrderRepo();
  //late OrderImagesDataModel _orderImagesDataModel;
  late OrderDataModel _orderDataModel;
  late OrderSubmitModel _orderSubmitModel;

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
  int orderDetailsTypeInitialIndex = -1;
  int orderDetailsTypeIndex = -1;

 
  TextEditingController orderRecieveFloorController = TextEditingController();
  TextEditingController orderSendFloorController = TextEditingController();
  List<String> additionalService = [
    'متوفر',
    'غير متوفر',
  ];
  int elevatorAvilabelIndex = -1;
  int extramanAvilabelIndex = -1;
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
    log('additionalServiceIndex1:$elevatorAvilabelIndex');
    log('additionalServiceIndex2:$extramanAvilabelIndex');

    return carIndex != -1 &&
        orderTypeIndex != -1 &&
        orderDescriptionController.text.isNotEmpty &&
        orderDetailsTypeIndex != -1 &&
        orderRecieveFloorController.text.isNotEmpty &&
        orderSendFloorController.text.isNotEmpty &&
        elevatorAvilabelIndex != -1 &&
        extramanAvilabelIndex != -1;
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

  void viewCounter() {
    currentStep++;
    
    emit(OrderCounter());
  }

  _sendOrderData(OrderEvent events, Emitter emit) async {
    emit(OrderLoading());
    try {
      List<double> picupCoordinates=await LocationHandler.getLocationFromAddress(location: orderRecieveLocationController.text);
      List<double> deliveryCoordinates=await LocationHandler.getLocationFromAddress(location: orderRecieveLocationController.text);
      
      Map<String, dynamic> data = {
        "carType": carIndex,
        "shipmentType": orderTypeIndex,
        "shipmentDescription": orderDescriptionController.text,
        "pickupFloor": int.parse(orderRecieveFloorController.text),
        "deleviryFloor": int.parse(orderSendFloorController.text),
        "elevatorAvilabel": elevatorAvilabelIndex,
        "extramanAvilabel": extramanAvilabelIndex,
        'uploadaAndDownloadServices':orderDetailsTypeIndex,
        'pickupLat':picupCoordinates[0],
        'pickupLong':picupCoordinates[1],
        'deleviryLat':deliveryCoordinates[0],
        'deleviryLong':deliveryCoordinates[1],
        "pickupLocation": orderRecieveLocationController.text,
        // To Do : check loop for images
        "deleviryLocation": orderSendLocationController.text,
      };

      _orderDataModel = await _sendOrderDataRepo.sendOrderRequest(data);
      log('_sendOrderDataModel: $_orderDataModel');
      viewCounter();
      /* AppRoutes.pushNamedNavigator(
        routeName: Routes.payment, /*  replacement: true */
      ); */
      emit(OrderLoaded());
    } catch (e) {
      emit(OrderError('order bloc error:$e'));
    }
  }

  _sendOrderImages(OrderEvent events, Emitter emit) async {
    emit(OrderLoading());
    try {
      Map<String, dynamic> data = {};
      data = {
        "order_id": _orderDataModel.orderId.toString(),
      };
      for (int i = 0; i < imagesList.length; i++) {
        //  data['images[$i]'] = imagesList[i];
        data['images[$i]'] = MultipartFile.fromFileSync(
          imagesList[i].path,
          filename: imagesList[i].path.split("/").last,
        );
      }

      log('messages: ${data.toString()}');
      // data['order_id'] = _sendOrderDataModel.orderId;
      _orderDataModel =
          await _sendOrderDataRepo.sendImagesRequest(FormData.fromMap(data));
      /* log('_sendOrderDataModel: $_sendOrderDataModel'); */
      log('send images success');
      viewCounter();
      /* AppRoutes.pushNamedNavigator(
        routeName: Routes.payment, /*  replacement: true */
      ); */
      emit(OrderLoaded());
    } catch (e) {
      emit(OrderError('order images bloc error:$e'));
    }
  }

  _sendSubmitOrder(OrderEvent events, Emitter emit) async {
    emit(OrderLoading());
    try {
      Map<String, dynamic> data = {};
      data = {
        "order_id": _orderDataModel.orderId,
      };
      log('submit data: ${data.toString()}');
      _orderSubmitModel =
          await _sendOrderDataRepo.sendSubmitRequest(data);

      log('send images success');
      AppRoutes.pushNamedNavigator(
        routeName: Routes.payment, /*  replacement: true */
      );
      emit(OrderLoaded());
    } catch (e) {
      emit(OrderError('order Submit bloc error:$e'));
    }
  }
}
