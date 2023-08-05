import 'package:dio/dio.dart';

import 'dio_interceptor.dart';

class AuthDioClient {
  final _dio = Dio(BaseOptions(
      connectTimeout: const Duration(milliseconds: 10000),
      receiveTimeout: const Duration(milliseconds: 10000),
      baseUrl: "http://164.164.122.69:8081/AndroidTest/api/auth"));

  Dio get dio => _dio;
}

class UserDioClient {
  final _dio = Dio(BaseOptions(
      connectTimeout: const Duration(milliseconds: 10000),
      receiveTimeout: const Duration(milliseconds: 10000),
      baseUrl: "http://164.164.122.69:8081/AndroidTest/api/auth"));

  UserDioClient() {
    _dio.interceptors.add(DioInterceptor());
  }

  Dio get dio => _dio;
}
