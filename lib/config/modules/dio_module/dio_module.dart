import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/constants/api/api_endpoints.dart';
import 'logger_interceptor.dart';

@module
abstract class DioModule {
  @singleton
  Dio dio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      ),
    );
    dio.interceptors.add(LoggerInterceptor());
    return dio;
  }
}