import 'app_exception.dart';
import 'exception_constant_messages.dart';

enum AuthFailureReason {
  invalidCredentials,
  userNotFound,
  weakPassword,
  emailAlreadyInUse,
  sessionExpired,
  unknown,
}

class AuthException extends AppException {
  final AuthFailureReason? reason;

  AuthException({
    this.reason,
    required super.message,
    super.code,
    super.originalException,
    super.stackTrace,
  });

  @override
  String getUserMessage() {
    switch (reason) {
      case AuthFailureReason.invalidCredentials:
        return ExceptionConstantMessages.invalidEmailOrPassword;
      case AuthFailureReason.userNotFound:
        return ExceptionConstantMessages.userAccountNotFound;
      case AuthFailureReason.weakPassword:
        return ExceptionConstantMessages.weakPassword;
      case AuthFailureReason.emailAlreadyInUse:
        return ExceptionConstantMessages.emailAlreadyRegistered;
      case AuthFailureReason.sessionExpired:
        return ExceptionConstantMessages.sessionExpired;
      default:
        return ExceptionConstantMessages.unexpectedError;
    }
  }
}
