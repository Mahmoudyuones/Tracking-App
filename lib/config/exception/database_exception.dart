import 'app_exception.dart';
import 'exception_constant_messages.dart';

class DatabaseException extends AppException {
  DatabaseException({
    required super.message,
    super.code,
    super.originalException,
    super.stackTrace,
  });

  @override
  String getUserMessage() => ExceptionConstantMessages.databaseError;
}
