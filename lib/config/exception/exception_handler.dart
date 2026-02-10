import 'dart:async' as async;
import 'dart:developer';

import 'package:dio/dio.dart';

import 'app_exception.dart';
import 'server_exception.dart';
import 'timeout_exception.dart';
import 'unknown_exception.dart';
import 'validation_exception.dart';

class ExceptionHandler {
  static AppException handle({dynamic exception, StackTrace? stackTrace}) {
    if (exception is DioException) {
      return _handleDioError(exception, stackTrace);
    }

    return switch (exception) {
      final AppException e => e,
      final FormatException e => ValidationException(
        message: e.message,
        originalException: e,
        stackTrace: stackTrace,
      ),
      final async.TimeoutException e => TimeoutExceptions(
        message: e.message.toString(),
        originalException: e,
        stackTrace: stackTrace,
      ),
      _ => UnknownException(
        message: exception.toString(),
        originalException: exception,
        stackTrace: stackTrace,
      ),
    };
  }

  static AppException _handleDioError(
    DioException error,
    StackTrace? stackTrace,
  ) {
    return ServerException(
      statusCode: error.response?.statusCode,
      message: error.message ?? 'Network error',
      originalException: error,
      stackTrace: stackTrace,
    );
  }

  // Send to Firebase Crashlytics if available
  // FirebaseCrashlytics.instance.recordError(exception, exception.stackTrace);
  static void logException(AppException exception) {
    final message = exception.getDetailedMessage();
    log('=== APP EXCEPTION ===');
    log(message);
    if (exception.stackTrace != null) {
      log('Stack Trace:\n${exception.stackTrace}');
    }
    log('====================');
  }
}
