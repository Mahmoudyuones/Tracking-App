import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../domain/entities/driver_response_entity.dart';
import '../../domain/repos/my_profile_repo.dart';
import '../datasources/my_profile_remote_data_source.dart';

@Injectable(as: MyProfileRepo)
class MyProfileRepoImpl implements MyProfileRepo {
  final MyProfileRemoteDataSource _myProfileRemoteDataSource;
  MyProfileRepoImpl(this._myProfileRemoteDataSource);
  @override
  Future<BaseResponse<DriverResponseEntity>> getMyProfileData() async {
    final response = await _myProfileRemoteDataSource.getMyProfileData();
    return response.when(
      success: (success) => BaseResponse.success(success.toEntity()),
      failure: (failure) => BaseResponse.failure(failure),
    );
  }
}
