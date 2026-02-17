class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = 'https://flower.elevateegy.com/api/v1';
  static const String idPathQuery = 'Id';

  // ------------------------ AUTHENTICATION ENDPOINTS ------------------------ //
  static const String changePassword = '/drivers/change-password';

  // ------------------------ TRACK ORDER ENDPOINTS ------------------------ //
  static const String updateOrderState = '/orders/state/{Id}';
}
