import 'package:dio/dio.dart';
import 'package:flutter_caffe_ku/core/data/api.dart';
import 'package:flutter_caffe_ku/core/data/base_api_impl.dart';
import 'package:flutter_caffe_ku/core/models/api/api_response.dart';
import 'package:flutter_caffe_ku/core/utils/token/token_utils.dart';
import 'package:flutter_caffe_ku/injector.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class BaseAPI implements BaseAPIImpl {
  Dio? _dio;

  final endpoint = locator<Api>();

  /// Initialize constructors
  BaseAPI({Dio? dio}) {
    _dio = dio ?? Dio();
    _dio?.interceptors.add(PrettyDioLogger(
      requestBody: true,
      requestHeader: true,
      error: true,
    ));
  }

  @override
  Future<APIResponse> delete(String url,
      {Map<String, dynamic>? param, bool? useToken}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<APIResponse> get(String url,
      {Map<String, dynamic>? param, bool? useToken}) async {
    try {
      final result = await _dio?.get(
        url,
        options: await getHeaders(useToken: useToken),
        queryParameters: param,
      );

      return _parseRespponse(result);
    } on DioException catch (e) {
      return APIResponse.failure(e.response?.statusCode ?? 500);
    }
  }

  @override
  Future<APIResponse> post(String url,
      {Map<String, dynamic>? param, data, bool? useToken}) async {
    try {
      final result = await _dio?.post(
        url,
        options: await getHeaders(useToken: useToken),
        data: data,
        queryParameters: param,
      );

      return _parseRespponse(result);
    } on DioException catch (e) {
      return APIResponse.failure(e.response?.statusCode ?? 404);
    }
  }

  @override
  Future<APIResponse> put(String url,
      {Map<String, dynamic>? param, data, bool? useToken}) {
    // TODO: implement put
    throw UnimplementedError();
  }

  Future<APIResponse> _parseRespponse(Response? response) async {
    return APIResponse.fromJson({
      'statusCode': response?.statusCode,
      'data': response?.data,
    });
  }

  Future<Options> getHeaders({bool? useToken}) async {
    // final token = await checkTokken.getTokenUser();
    var header = <String, dynamic>{};
    header['Accept'] = 'application/json';
    header['Content-Type'] = 'application/json; charset=UTF-8';
    if (useToken == true) {
      header['Authorization'] = '';
    }

    return Options(
      headers: header,
      sendTimeout: const Duration(seconds: 60), // 60 seconds
      receiveTimeout: const Duration(seconds: 60), // 60 seconds
    );
  }
}
