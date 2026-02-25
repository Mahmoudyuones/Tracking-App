import '../../../../config/base_response/base_response.dart';
import '../models/driver_response_model.dart';

abstract interface class MyProfileRemoteDataSource {
  Future<BaseResponse<DriverResponseModel>> getMyProfileData();
}
