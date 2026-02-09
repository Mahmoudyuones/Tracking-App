import '../failure/failure.dart';
import 'server_exception.dart';

abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalException;
  final StackTrace? stackTrace;

  AppException({
    required this.message,
    this.code,
    this.originalException,
    this.stackTrace,
  });

  Failure toFailure() {
    // If it's already a ServerException, we pass the status code
    if (this is ServerException) {
      return ServerFailure(
        message: getUserMessage(),
        statusCode: (this as ServerException).statusCode,
      );
    }
    // Fallback for other exceptions
    return ServerFailure(message: getUserMessage());
  }

  // Get a UI error message
  String getUserMessage();

  // Get a detailed message for logging/debugging
  String getDetailedMessage() {
    final buffer = StringBuffer();
    buffer.writeln('Exception: $runtimeType');
    buffer.writeln('Message: $message');
    if (code != null) buffer.writeln('Code: $code');
    if (originalException != null) {
      buffer.writeln('Original Exception: $originalException');
    }
    return buffer.toString();
  }

  @override
  String toString() => message;
}
