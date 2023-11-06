import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pick_up/config/end_points.dart';
import 'package:pick_up/features/client_home/data/model/image_slider_model.dart';
import 'package:pick_up/handlers/shared_handler.dart';
import 'package:pick_up/network/web_services.dart';

class HomeRepo {
  /* final Network _pickupNetwork = Network(); */
  /* getImageSlider() async {
    return await _pickupNetwork.getData(url: 'home');
  } */
  Future<ImageSlider> getImageSlider() async {
    try {
      final Response res = await Network.instance!.get(headers: {
        'auth-token': SharedHandler.instance!
            .getData(key: SharedKeys().token, valueType: ValueType.string)!
      }, url: ApiNames.baseUrl + ApiNames.imageSlider);
      log(ApiNames.imageSlider);
      log('message: ${res.data.toString()}');
      ImageSlider imageSlider = ImageSlider.fromJson(res.data);
      /* log(imageSlider.toString()); */
      return imageSlider;
    } catch (e) {
      rethrow;
    }
  }
}
