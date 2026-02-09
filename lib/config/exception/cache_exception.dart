import 'app_exception.dart';

class CacheException extends AppException {
  CacheException({
    required super.message,
    super.code,
    super.originalException,
    super.stackTrace,
  });

  @override
  String getUserMessage() => 'Failed to load data. Please try again.';
}
