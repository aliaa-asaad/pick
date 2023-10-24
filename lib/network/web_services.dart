import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pick_up/config/end_points.dart';
import 'package:pick_up/handlers/shared_handler.dart';

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
      bool withToken = true,
      /* Map<String, dynamic>? headers */}) async {
    try {
      Response res;
      String token='';
      /* if (headers != null) {
        _dio.options.headers = headers;
      } */ /* else if (withToken) { */
        token = await SharedHandler.instance!
            .getData(key: SharedKeys().token, valueType: ValueType.string);
        log("Post -> url: $url");
        log('Post -> body:$body');
        /* _dio.options.headers = {
          'Token': 'Bearer $token',
          'Accept': 'application/json',
          // 'Accept-Language': "US"
        };
        log("Post -> headers: ${_dio.options.headers}"); */
      /* } */
log("Post -> headers2: ${_dio.options.headers}");
      log('test');
      res = await _dio.post(url!,
          data: body,
          //queryParameters: query,
          options: Options(headers: {
            'Token': 'Bearer $token',
            'Accept': 'application/json',
          },));
          log("Post -> headers1: ${_dio.options.headers}");
      log("Post -> headers: Token': 'Bearer jzjlxhladfjladj,Accept': 'application/json");
      log('res: ${res.toString()}');
      log('status: ${res.statusCode}');
      log('data: ${res.data}');
      // log_request(request: url, requestMethod: "POST", query: query ?? {}, body: body ?? {}, headers: _dio.options.headers);
      return res;
    } on DioException catch (e) {
      log('Dio exception: ${e.response!.data.toString()}');
      rethrow;
    } catch (e) {
      log('catch: ${e.toString()}');

      rethrow;
    }
  }
}

/* class DioHelper {
  static final _dio = Dio(BaseOptions(
    baseUrl: 'https://api.nmc.com.eg/public/api/',
  ));

  static Future<CustomResponse> sendData(String endPoint, String? token,
      {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(endPoint,
          data: data,
          options: token != null
              ? Options(
                  headers: {"Token": "Bearer $token"},
                )
              : null);
      print(response);
      return CustomResponse(stauts: true, response: response);
    } on DioException catch (ex) {
      print(ex.error);
      return CustomResponse(stauts: false);
    }
  }

  static final dio_ = Dio(
    BaseOptions(baseUrl: 'https://api.nmc.com.eg/public/api/'),
  );
  static Future<CustomResponse> getData(String endPoint, String? token,
      {Map<String, dynamic>? params}) async {
    print("test");
    try {
      final response = await dio_.get(endPoint,
          options: token != null
              ? Options(
                  headers: {
                    "Token": "Bearer $token",
                    'Accept': 'application/json',
                  },
                )
              : null);

      return CustomResponse(stauts: true, response: response);
    } on DioException catch (ex) {
      return CustomResponse(stauts: false);
    }
    ;
  }
}

class CustomResponse {
  final Response? response;
  final bool? stauts;
  CustomResponse({
    this.response,
    this.stauts,
  });
}
 */