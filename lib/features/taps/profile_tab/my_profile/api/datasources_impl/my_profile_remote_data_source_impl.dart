import 'package:injectable/injectable.dart';

import '../../../../../../config/base_response/base_response.dart';
import '../../../../../../config/safe_api_call/safe_api_call.dart';
import '../../data/datasources/my_profile_remote_data_source.dart';
import '../../data/models/driver_response_model.dart';
import '../api_client/my_profile_api_client.dart';

@LazySingleton(as: MyProfileRemoteDataSource)
class MyProfileRemoteDataSourceImpl implements MyProfileRemoteDataSource {
  final MyProfileApiClient _myProfileApiClient;
  MyProfileRemoteDataSourceImpl(this._myProfileApiClient);
  @override
  Future<BaseResponse<DriverResponseModel>> getMyProfileData() =>
      safeApiCall(() => _myProfileApiClient.getMyProfileData());

  @override
  Future<BaseResponse<void>> logout() =>
      safeApiCall(() => _myProfileApiClient.logout());
}
