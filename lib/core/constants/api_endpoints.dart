class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = 'https://flower.elevateegy.com/api/v1/';
  static const String basePhoto = 'https://flower.elevateegy.com/uploads/';
  static const String idPathQuery = 'Id';

  // ------------------------ AUTHENTICATION ENDPOINTS ------------------------ //
  static const loginEndPoint = 'drivers/signin';
  static const String forgotPassword = 'drivers/forgotPassword';
  static const String verifyResetCode = 'drivers/verifyResetCode';
  static const String resetPassword = 'drivers/resetPassword';
  static const String changePassword = 'drivers/change-password';
  static const String apply = 'drivers/apply';

  // ------------------------ TRACK ORDER ENDPOINTS ------------------------ //
  static const String updateOrderState = 'orders/state/{Id}';
  static const String uploadedPhotos = 'https://flower.elevateegy.com/uploads/';

  // ------------------------  PROFILE ENDPOINTS ------------------------ //
  static const String myProfile = 'drivers/profile-data';
  static const String editProfile = 'drivers/editProfile';
  static const String updateProfileImage = 'drivers/upload-photo';
  static const String logout = 'drivers/logout';

  // ------------------------  ORDERS ENDPOINTS ------------------------ //
  static const String orders = 'orders/driver-orders';
  static const String productDetails = 'products/{Id}';
  static const String pendingOrders = 'orders/pending-orders';
  static const String startOrder = 'orders/start/{orderId}';
}
