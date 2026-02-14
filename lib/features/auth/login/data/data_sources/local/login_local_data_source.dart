import '../../../../../../config/base_response/base_response.dart';

abstract interface class LoginLocalDataSource {
  Future<BaseResponse<void>> saveLoggedUserData({required String token});
}
