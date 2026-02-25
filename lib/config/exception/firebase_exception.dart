import 'app_exception.dart';

class FirebaseCustomException extends AppException {
  FirebaseCustomException({required super.message});

  @override
  String getUserMessage() => message;
}
