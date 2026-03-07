import 'package:injectable/injectable.dart';

import '../../../../../../config/base_response/base_response.dart';
import '../../../../../../config/safe_api_call/safe_api_call.dart';
import '../../../../api/shared_api_client/shared_auth_api_client.dart';
import '../../../data/data_sources/remote/login_remote_data_source.dart';
import '../../../data/models/login_request_model/login_request_model.dart';
import '../../../data/models/login_response_model/login_response_model.dart';

@Injectable(as: LoginRemoteDataSource)
class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final SharedAuthApiClient _apiClient;

  const LoginRemoteDataSourceImpl(this._apiClient);

  @override
  Future<BaseResponse<LoginResponseModel>> login(LoginRequestModel body) =>
      safeApiCall(() => _apiClient.login(body));
}
