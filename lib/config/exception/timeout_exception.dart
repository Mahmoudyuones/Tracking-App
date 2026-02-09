import 'app_exception.dart';

class TimeoutExceptions extends AppException {
  TimeoutExceptions({
    required super.message,
    super.code,
    super.originalException,
    super.stackTrace,
  });

  @override
  String getUserMessage() =>
      'Request timed out. Please check your connection and try again.';
}
