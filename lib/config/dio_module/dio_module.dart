import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../core/constants/api_endpoints.dart';
import '../interceptors/auth_interceptor.dart';
import '../interceptors/logger_interceptor.dart';

@module
abstract class DioModule {
  @singleton
  Dio dio(
    AuthInterceptor authInterceptor,
    LoggerInterceptor loggerInterceptor,
  ) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      ),
    );

    // Add the auth interceptor to automatically handle token injection
    dio.interceptors.add(authInterceptor);
    // Add the PrettyDioLogger interceptor for logging requests and responses
    if (kDebugMode) {
      dio.interceptors.add(loggerInterceptor);
    }
    return dio;
  }
}
