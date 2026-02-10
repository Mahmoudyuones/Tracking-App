import 'app_exception.dart';
import 'exception_constant_messages.dart';

class FileException extends AppException {
  final String? filePath;

  FileException({
    this.filePath,
    required super.message,
    super.code,
    super.originalException,
    super.stackTrace,
  });

  @override
  String getUserMessage() => ExceptionConstantMessages.fileError;
}
