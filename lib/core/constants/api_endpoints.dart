class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = 'https://flower.elevateegy.com/api/v1/drivers/';
  static const String idPathQuery = 'Id';

  // ------------------------ AUTHENTICATION ENDPOINTS ------------------------ //
  static const String forgotPassword = 'drivers/forgotPassword';
  static const String verifyResetCode = 'drivers/verifyResetCode';
  static const String resetPassword = 'drivers/resetPassword';
  static const String changePassword = 'drivers/change-password';

  // ------------------------ TRACK ORDER ENDPOINTS ------------------------ //
  static const String updateOrderState = 'orders/state/{Id}';

  // ------------------------  PROFILE ENDPOINTS ------------------------ //
  static const String myProfile = 'profile-data';
  static const String editProfile = 'drivers/editProfile';
  static const String updateProfileImage = 'drivers/upload-photo';
}
