import 'app_exception.dart';
import 'exception_constant_messages.dart';

class UnknownException extends AppException {
  UnknownException({
    required super.message,
    super.code,
    super.originalException,
    super.stackTrace,
  });

  @override
  String getUserMessage() => ExceptionConstantMessages.unexpectedError;
}
