import 'app_exception.dart';
import 'exception_constant_messages.dart';

class ValidationException extends AppException {
  final Map<String, String>? fieldErrors;

  ValidationException({
    this.fieldErrors,
    required super.message,
    super.code,
    super.originalException,
    super.stackTrace,
  });

  @override
  String getUserMessage() => ExceptionConstantMessages.validationError;
}
