import 'app_exception.dart';
import 'exception_constant_messages.dart';

class NetworkException extends AppException {
  NetworkException({
    required super.message,
    super.code,
    super.originalException,
    super.stackTrace,
  });

  @override
  String getUserMessage() => ExceptionConstantMessages.networkError;
}
