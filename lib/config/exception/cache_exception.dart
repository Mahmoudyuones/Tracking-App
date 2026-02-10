import 'app_exception.dart';
import 'exception_constant_messages.dart';

class CacheException extends AppException {
  CacheException({
    required super.message,
    super.code,
    super.originalException,
    super.stackTrace,
  });

  @override
  String getUserMessage() => ExceptionConstantMessages.cashError;
}
