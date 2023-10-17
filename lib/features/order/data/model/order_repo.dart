import 'package:dio/dio.dart';
import 'package:pick_up/config/end_points.dart';
import 'package:pick_up/features/order/data/model/send_order_model.dart';
import 'package:pick_up/network/web_services.dart';

class SendOrderRepo {
  /* final Network _pickupNetwork = Network(); */

  Future<SendOrderModel> sendOrderRequest(Map<String, dynamic> data) async {
    try {
      Response res = await Network.instance!.post(
          url: ApiNames.baseUrl + ApiNames.orderEndPoint, body: data);

      return SendOrderModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }
}
