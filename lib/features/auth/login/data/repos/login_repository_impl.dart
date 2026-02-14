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
        _handelSaveToken(remembered: remembered, model: model);
        return BaseResponse.success(model);
      },
      failure: (e) {
        return BaseResponse.failure(e);
      },
    );
  }

  Future _handelSaveToken({
    required bool remembered,
    required LoginResponseModel model,
  }) async {
    if (remembered && model.token != null) {
      final localResult = await _localDataSource.saveLoggedUserData(
        token: model.token!,
      );
      return localResult.when(
        success: (_) => BaseResponse.success(model),
        failure: (failure) => BaseResponse.failure(failure),
      );
    }
  }
}
