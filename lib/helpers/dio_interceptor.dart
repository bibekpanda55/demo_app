import 'dart:math';

import 'package:dio/dio.dart';

import '../main.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] =
        "Bearer ${sp.getString('access_token')!}";
    options.headers['content-Type'] = 'application/json';
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print(err);
    super.onError(err, handler);
  }
}
