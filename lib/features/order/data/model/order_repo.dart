import 'package:dio/dio.dart';
import 'package:pick_up/config/end_points.dart';
import 'package:pick_up/features/order/data/model/send_order_model.dart';
import 'package:pick_up/network/web_services.dart';

class SendOrderRepo {
  /* final Network _pickupNetwork = Network(); */

  Future<SendOrderDataModel> sendOrderRequest(Map<String, dynamic> data) async {
    try {
      Response res = await Network.instance!.post(
          url: ApiNames.orderEndPoint, body: data);

      return SendOrderDataModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }
}
