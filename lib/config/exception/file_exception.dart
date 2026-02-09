import 'app_exception.dart';

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
  String getUserMessage() => 'File operation failed. Please try again.';
}
