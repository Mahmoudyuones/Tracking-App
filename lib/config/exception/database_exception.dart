import 'app_exception.dart';

class DatabaseException extends AppException {
  DatabaseException({
    required super.message,
    super.code,
    super.originalException,
    super.stackTrace,
  });

  @override
  String getUserMessage() =>
      'Database error occurred. Please try again.';
}