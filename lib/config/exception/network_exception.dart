import 'app_exception.dart';

class NetworkException extends AppException {
  NetworkException({
    required super.message,
    super.code,
    super.originalException,
    super.stackTrace,
  });

  @override
  String getUserMessage() =>
      'Network error. Please check your internet connection and try again.';
}
