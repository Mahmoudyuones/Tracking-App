import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../domain/repos/login_repository.dart';
import '../data_sources/local/login_local_data_source.dart';
import '../data_sources/remote/login_remote_data_source.dart';
import '../models/login_request_model/login_request_model.dart';
import '../models/login_response_model/login_response_model.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource _remoteDataSource;
  final LoginLocalDataSource _localDataSource;

  const LoginRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<BaseResponse<LoginResponseModel>> login({
    required LoginRequestModel request,
    bool remembered = false,
  }) async {
    final response = await _remoteDataSource.login(request);
    return response.when(
      success: (model) async {
        if (model.token != null) {
          await _localDataSource.saveLoginData(
            token: model.token!,
            userData: model.toJson(),
          );
        }
        return BaseResponse.success(model);
      },
      failure: (e) {
        return BaseResponse.failure(e);
      },
    );
  }
}
