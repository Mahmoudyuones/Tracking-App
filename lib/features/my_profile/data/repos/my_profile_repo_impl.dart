import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../../../config/services/token_service.dart';
import '../../domain/entities/driver_response_entity.dart';
import '../../domain/repos/my_profile_repo.dart';
import '../datasources/my_profile_remote_data_source.dart';

@Injectable(as: MyProfileRepo)
class MyProfileRepoImpl implements MyProfileRepo {
  final MyProfileRemoteDataSource _myProfileRemoteDataSource;
  final TokenService _tokenService;

  MyProfileRepoImpl(this._myProfileRemoteDataSource, this._tokenService);

  @override
  Future<BaseResponse<DriverResponseEntity>> getMyProfileData() async {
    final response = await _myProfileRemoteDataSource.getMyProfileData();
    return response.when(
      success: (success) => BaseResponse.success(success.toEntity()),
      failure: (failure) => BaseResponse.failure(failure),
    );
  }

  @override
  Future<BaseResponse<void>> logout() async {
    final response = await _myProfileRemoteDataSource.logout();
    return response.when(
      success: (_) async {
        final clearResult = await _tokenService.clearAuthData();
        return clearResult.when(
          success: (_) => const BaseResponse<void>.success(null),
          failure: (failure) => BaseResponse<void>.failure(failure),
        );
      },
      failure: (failure) => BaseResponse<void>.failure(failure),
    );
  }
}
