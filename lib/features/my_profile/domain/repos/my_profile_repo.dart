import '../../../../config/base_response/base_response.dart';
import '../entities/driver_response_entity.dart';

abstract interface class MyProfileRepo {
  Future<BaseResponse<DriverResponseEntity>> getMyProfileData();
  Future<BaseResponse<void>> logout();
}
