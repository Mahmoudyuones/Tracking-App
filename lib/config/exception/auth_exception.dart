import 'app_exception.dart';

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
        return 'Invalid email or password.';
      case AuthFailureReason.userNotFound:
        return 'User account not found.';
      case AuthFailureReason.weakPassword:
        return 'Password is too weak.';
      case AuthFailureReason.emailAlreadyInUse:
        return 'Email is already registered.';
      case AuthFailureReason.sessionExpired:
        return 'Your session has expired. Please log in again.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }
}
