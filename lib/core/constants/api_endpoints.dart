class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = 'https://flower.elevateegy.com/api/v1/drivers/';
  // ------------------------ AUTHENTICATION ENDPOINTS ------------------------ //
  static const String changePassword = 'change-password';
  static const String forgotPassword = 'forgotPassword';
  static const String verifyResetCode = 'verifyResetCode';
  static const String resetPassword = 'resetPassword';
}
