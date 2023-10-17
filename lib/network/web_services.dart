import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pick_up/config/end_points.dart';

class Network {
  static Network? instance;
  final Dio _dio = Dio();
  Network._internal();
  factory Network.init() {
    if (instance == null) {
      instance = Network._internal();
      instance!._dio.options.baseUrl = ApiNames.baseUrl;
    }
    return instance!;
  }


  Future<dynamic> get(
      {required String? url,
      Map<String, dynamic>? query,
      Map<String, dynamic>? headers,
      bool withToken = false}) async {
    Response? res;
    if (headers != null) {
      _dio.options.headers = headers;
    } else if (withToken) {
      String token = ""; // get the token
      // await SharedHelper.sharedHelper!.readString(CachingKey.TOKEN);
      _dio.options.headers = {
        'loginorization': 'Bearer $token',
        'Accept': 'application/json',
        'Accept-Language': "US"
      };
    }
    try {
      res = await _dio.get(url!, queryParameters: query);
      // log_request(request: url, requestMethod: "GET", query: query ?? {}, headers: _dio!.options.headers);
      return res;
    } on DioError {}
  }

  Future<dynamic> post(
      {required String? url,
      Map<String, dynamic>? body,
      Map<String, dynamic>? query,
      bool withToken = false,
      Map<String, dynamic>? headers}) async {
    log("Post -> url: $url");
    log('Post -> body:$body');
    _dio.options.headers = {
      //'loginorization': 'Bearer $token',
      'Accept': 'application/json',
      'Accept-Language': "US"
    };
    Response? res;
    if (headers != null) {
      _dio.options.headers = headers;
    } else if (withToken) {
      String token = ""; // get the token
      // await SharedHelper.sharedHelper!.readString(CachingKey.TOKEN);
      _dio.options.headers = {
        'loginorization': 'Bearer $token',
        /* 'Accept': 'application/json',
        'Accept-Language': "US" */
      };
    }

    try {
      res = await _dio.post(url!, data: body, queryParameters: query);
      // log_request(request: url, requestMethod: "POST", query: query ?? {}, body: body ?? {}, headers: _dio.options.headers);
      return res;
    } on DioException catch (e) {
      log(e.response!.data.toString());
      rethrow;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
