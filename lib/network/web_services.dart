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
      bool withToken = true}) async {
    String token = '';
    Response? res;
    if (headers != null) {
      _dio.options.headers = headers;
    } else if (withToken) {
      token = await SharedHandler.instance!
          .getData(key: SharedKeys().token, valueType: ValueType.string);
      _dio.options.headers = {
        'authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Accept-Language': "US"
      };
    }
    try {
      res = await _dio.get(url!,
          queryParameters: query,
          options: Options(headers: _dio.options.headers));
      // log_request(request: url, requestMethod: "GET", query: query ?? {}, headers: _dio!.options.headers);
      return res;
    } on DioException catch (e) {
      log('status: ${e.response!.statusMessage}');
      log('statusCode: ${e.response!.statusCode}');
      log('Dio exception: ${e.stackTrace}');
      log('message: ${e.message}');
      log('error: ${e.error.toString()}');
      // log('token headers: ${e.response!.headers.value('Accept')}');
      log('headers: ${e.response!.requestOptions.headers}');
      log('headers map: ${e.response!.headers.map}');
      log('headers token key: ${e.response!.headers.map.containsKey('authorization')}');

      log('Dio exception: ${e.response!.data.toString()}');
      rethrow;
    } catch (e) {
      log('catch: ${e.toString()}');

      rethrow;
    }
  }

  Future<dynamic> post(
      {required String? url,
      Map<String, dynamic>? body,
      bool isImageBody = false,
      FormData? imageBody,
      Map<String, dynamic>? query,
      bool withToken = true,
      Map<String, dynamic>? headers}) async {
    try {
      String token = '';
      Response res;
      if (headers != null) {
        _dio.options.headers = headers;
      } else if (withToken) {
        token = await SharedHandler.instance!
            .getData(key: SharedKeys().token, valueType: ValueType.string);
        log("Post -> url: $url");
        log('Post -> body:$body');
        log('token: $token');
        _dio.options.headers = {
          'authorization': 'Bearer $token',
          'Accept': 'application/json',
        };
      }

      res = await _dio.post(url!,
          data: isImageBody ? imageBody : body,
          queryParameters: query,
          options: Options(headers: _dio.options.headers));
      if (res.statusCode! >= 200 || res.statusCode! < 300) {
        return res;
      } else {
        throw Exception("Error");
      }
    } on DioException catch (e) {
      log('status: ${e.response!.statusMessage}');
      log('statusCode: ${e.response!.statusCode}');
      log('Dio exception: ${e.stackTrace}');
      log('message: ${e.message}');
      log('error: ${e.error.toString()}');
      // log('token headers: ${e.response!.headers.value('Accept')}');
      log('headers: ${e.response!.requestOptions.headers}');
      log('headers map: ${e.response!.headers.map}');
      log('headers token key: ${e.response!.headers.map.containsKey('authorization')}');
      log('post body: ${e.response!.requestOptions.data.toString()}');
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