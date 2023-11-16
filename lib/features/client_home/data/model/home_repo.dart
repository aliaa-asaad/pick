import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pick_up/config/end_points.dart';
import 'package:pick_up/features/client_home/data/model/home_slider_model.dart';
import 'package:pick_up/network/web_services.dart';

class HomeRepo {
 
  Future<List<Slider>> getHomeSlider() async {
    final Response res = await Network.instance!
        .get(url: ApiNames.imageSlider);
    log('home slider repo data: ${res.data.toString()}');
    log('home slider repo datatype: ${res.data.runtimeType}');
    if (res.statusCode! >= 200 && res.statusCode! < 300) {
      log('repo status code:${res.statusCode}');
      if (res.data.isNotEmpty) {
        return HomeSliderModel.fromJson(res.data).slider!;
      } else {
        log('home slider is empty');
        return [];
      }
    } else {
      log('get home slider repo error:${res.data}');
      throw Exception('Failed to load data!');
    }
  }
}
