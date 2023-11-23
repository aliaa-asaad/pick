import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pick_up/config/end_points.dart';
import 'package:pick_up/features/payment/data/model/eg_payment_details_model.dart';
import 'package:pick_up/features/payment/data/model/eg_payment_model.dart';
import 'package:pick_up/features/payment/data/model/ksa_payment_model.dart';
import 'package:pick_up/network/web_services.dart';

class PaymentRepo {
  Future<KSATransactionModel> sendKSAPaymentRequest(
      Map<String, dynamic> data) async {
    /* try { */
    Response res = await Network.instance!
        .post(url: ApiNames.paymentEndPoint, body: data, withToken: false);
    log('repo response ${res.data}');
    if (res.statusCode! >= 200 && res.statusCode! < 300) {
      return KSAPaymentModel.fromJson(res.data).data!.transaction!;
    } else {
      log('payment repo error:${res.data}');
      throw Exception('Failed to load data!');
    }
    /* } catch (e) {
      log('send order repo error:${e.toString()}');
      rethrow;
    } */
  }

  Future<List<EGData>> getEGPaymentMethodsRequest() async {
    /* try { */
    Response res = await Network.instance!.get(
        url:
            'https://pickupksa.com/apiEg/public/api/paymentMethods' /* ApiNames.paymentMethodsEGEndPoint */,
        withToken: false);
    log('repo response ${res.data}');
    if (res.statusCode! >= 200 && res.statusCode! < 300) {
      if (res.data.isNotEmpty) {
        return EgyptPaymentModel.fromJson(res.data).data!.data!;
      } else {
        return [];
      }
    } else {
      log('get payment repo error:${res.data}');
      throw Exception('Failed to load data!');
    }
    /* } catch (e) {
      log('send order repo error:${e.toString()}');
      rethrow;
    } */
  }

  Future<EGPaymentDetailsData> postEGPaymentMethodsRequest(
      Map<String, dynamic> data) async {
    /* try { */
    Response res = await Network.instance!.post(
        url: 'https://pickupksa.com/apiEg/public/api/executePayment',
        body: data,
       
        withToken: false);
    log('repo response ${res.data}');
    if (res.statusCode! >= 200 && res.statusCode! < 300) {
      return EGPaymentDetails.fromJson(res.data).data!.paymentData!;
    } else {
      log('get payment repo error:${res.data}');
      throw Exception('Failed to load data!');
    }
    /* } catch (e) {
      log('send order repo error:${e.toString()}');
      rethrow;
    } */
  }
}
