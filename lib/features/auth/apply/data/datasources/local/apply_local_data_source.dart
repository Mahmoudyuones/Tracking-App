import '../../../../../../config/base_response/base_response.dart';

abstract interface class ApplyLocalDataSource {
  Future<BaseResponse<void>> saveToken(String token);
}
