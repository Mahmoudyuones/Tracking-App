import 'app_exception.dart';

class UnknownException extends AppException {
  UnknownException({
    required super.message,
    super.code,
    super.originalException,
    super.stackTrace,
  });

  @override
  String getUserMessage() => 'An unexpected error occurred. Please try again.';
}
