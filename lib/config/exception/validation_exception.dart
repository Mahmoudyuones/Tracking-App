import 'app_exception.dart';

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
  String getUserMessage() => 'Validation failed. Please check your input.';
}