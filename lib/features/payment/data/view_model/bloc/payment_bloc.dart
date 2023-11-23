import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pick_up/config/end_points.dart';
import 'package:pick_up/features/my_order/data/view_model/bloc/my_order_bloc.dart';
import 'package:pick_up/features/order/data/view_model/bloc/order_bloc.dart';
import 'package:pick_up/features/payment/data/model/eg_payment_details_model.dart';
import 'package:pick_up/features/payment/data/model/eg_payment_model.dart';
import 'package:pick_up/features/payment/data/model/ksa_payment_model.dart';
import 'package:pick_up/features/payment/data/model/payment_repo.dart';
import 'package:pick_up/handlers/shared_handler.dart';
import 'package:pick_up/handlers/url_launcher_handler.dart';
import 'package:pick_up/routing/navigator.dart';
import 'package:pick_up/routing/routes.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial()) {
    /*  on<PaymentEvent>((event, emit) {
      // TODO: implement event handler
    }); */
    on<KSAPaymentClick>(_sendKSAPayment);
    on<GetEGPaymentClick>(_getEGPayment);
    on<PostEGPaymentClick>(_postEGPayment);
  }
  static PaymentBloc get instance =>
      BlocProvider.of(AppRoutes.navigatorState.currentContext!);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late KSATransactionModel transition;
  late List<EGData> egPaymentMethods = [];
  late EGPaymentDetailsData egPaymentDetails;
  String code = '';
  String expiredDate = 'لا يوجد تاريخ انتهاء';
  final PaymentRepo _sendPaymentRepo = PaymentRepo();
  int paymentMethod = -1;
  isValidPaymentMethod() {
    if (paymentMethod == -1) {
      return false;
    } else {
      return true;
    }
  }

  _sendKSAPayment(PaymentEvent events, Emitter emit) async {
    emit(PaymentLoading());
    try {
      log('ApiNames.baseUrl: ${ApiNames.baseUrl}');
      log('ApiNames.baseUrl');
      Map<String, dynamic> data = {
        "amount": OrderBloc.instance.orderDataModel.price.toString(),
        "description": OrderBloc.instance.orderDescriptionController.text,
        "fullName": SharedHandler.instance!.getData(
            key: SharedKeys().user, valueType: ValueType.map)['fullName'],
        "customer_email": SharedHandler.instance!
            .getData(key: SharedKeys().user, valueType: ValueType.map)['email'],
        "phone": SharedHandler.instance!.getData(
            key: SharedKeys().user, valueType: ValueType.map)['phoneNumber'],
      };
      log('data: $data');
      transition = await _sendPaymentRepo.sendKSAPaymentRequest(data);
      log('_sendPaymentModel: $transition');
      UrlLauncherHandler.openURL(url: transition.url!);

      emit(PaymentLoaded());
    } catch (e) {
      log('send payment bloc error:${e.toString()}');
      emit(PaymentError());
    }
  }

  _getEGPayment(PaymentEvent events, Emitter emit) async {
    emit(PaymentLoading());
    try {
      log('ApiNames.baseUrl: ${ApiNames.baseUrl}');
      log('ApiNames.baseUrl');

      egPaymentMethods = await _sendPaymentRepo.getEGPaymentMethodsRequest();
      log('_getPaymentModel: $egPaymentMethods');
      AppRoutes.pushNamedNavigator(routeName: Routes.egPaymentMethods);

      emit(PaymentLoaded());
    } catch (e) {
      log('get payment bloc error:${e.toString()}');
      emit(PaymentError());
    }
  }

  _postEGPayment(PaymentEvent events, Emitter emit) async {
    emit(PaymentLoading());
    try {
      log('ApiNames.baseUrl: ${ApiNames.baseUrl}');
      log('ApiNames.baseUrl');
      Map<String, dynamic> data = {
        "order_id": MyOrderBloc.instance.orderDetailsModel.id.toString(),
        "fullName": SharedHandler.instance!.getData(
            key: SharedKeys().user, valueType: ValueType.map)['fullName'],
        "description": OrderBloc.instance.orderDescriptionController.text,
        "email": SharedHandler.instance!
            .getData(key: SharedKeys().user, valueType: ValueType.map)['email'],
        "phone": SharedHandler.instance!.getData(
            key: SharedKeys().user, valueType: ValueType.map)['phoneNumber'],
        'address':
            MyOrderBloc.instance.orderDetailsModel.pickupLocation ?? 'القاهرة',
        'shipmentType':
            MyOrderBloc.instance.orderDetailsModel.shipmentType ?? '',
        'price': /* MyOrderBloc.instance.orderDetailsModel.price.toString() */
            '10',
        'payment_method_id': PaymentBloc.instance
            .egPaymentMethods[PaymentBloc.instance.paymentMethod].paymentId
            .toString(),
        'cartTotal': /* MyOrderBloc.instance.orderDetailsModel.price.toString() */
            '10',
      };
      log('data: $data');
      egPaymentDetails =
          await _sendPaymentRepo.postEGPaymentMethodsRequest(data);
      if (egPaymentDetails.redirectTo!.isNotEmpty) {
        UrlLauncherHandler.openURL(url: egPaymentDetails.redirectTo!);
      } else if (egPaymentDetails.fawryCode!.isNotEmpty) {
        code = egPaymentDetails.fawryCode!;
        expiredDate = egPaymentDetails.expireDate!;
        AppRoutes.pushNamedNavigator(routeName: Routes.egPaymentCode);
      } else if (egPaymentDetails.meezaQrCode!.isNotEmpty) {
        code = egPaymentDetails.meezaReference!;
        expiredDate = egPaymentDetails.meezaQrCode!;
        AppRoutes.pushNamedNavigator(routeName: Routes.egPaymentCode);
      } else if (egPaymentDetails.masaryCode!.isNotEmpty) {
        code = egPaymentDetails.masaryCode!;

        AppRoutes.pushNamedNavigator(routeName: Routes.egPaymentCode);
      } else if (egPaymentDetails.amanCode!.isNotEmpty) {
        code = egPaymentDetails.amanCode!;

        AppRoutes.pushNamedNavigator(routeName: Routes.egPaymentCode);
      }

      emit(PaymentLoaded());
    } catch (e) {
      log('send payment bloc error:${e.toString()}');
      emit(PaymentError());
    }
  }
}
