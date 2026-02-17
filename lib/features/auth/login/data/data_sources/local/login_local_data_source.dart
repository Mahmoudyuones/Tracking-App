import '../../../../../../config/base_response/base_response.dart';

abstract interface class LoginLocalDataSource {
  Future<BaseResponse<void>> saveLoginData({
    required String token,
    required Map<String, dynamic> userData,
  });
}
