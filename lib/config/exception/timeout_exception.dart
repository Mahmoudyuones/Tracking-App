import 'app_exception.dart';
import 'exception_constant_messages.dart';

class TimeoutExceptions extends AppException {
  TimeoutExceptions({
    required super.message,
    super.code,
    super.originalException,
    super.stackTrace,
  });

  @override
  String getUserMessage() => ExceptionConstantMessages.timeout;
}
