import 'package:injectable/injectable.dart';

import '../../data/data_sources/forget_password_data_source.dart';

import '../../data/models/request/forget_password_request_model.dart';
import '../../data/models/request/reset_password_request_model.dart';
import '../../data/models/request/verify_code_request_model.dart';
import '../../data/models/response/forget_password_response_model.dart';
import '../../data/models/response/reset_password_response_model.dart';
import '../../data/models/response/verify_code_response_model.dart';
import '../api_client/forget_password_api_client.dart';

@Injectable(as: ForgetPasswordDataSource)
class ForgetPasswordDataSourceImpl implements ForgetPasswordDataSource {
  final ForgetPasswordApiClient _apiClient;

  ForgetPasswordDataSourceImpl(this._apiClient);
  @override
  Future<ForgetPasswordResponseModel> forgetPassword(
    ForgetPasswordRequestModel request,
  ) async => await _apiClient.forgetPassword(request);

  @override
  Future<VerifyCodeResponseModel> verifyCode(
    VerifyCodeRequestModel request,
  ) async => _apiClient.verifyCode(request);

  @override
  Future<ResetPasswordResponseModel> resetPassword(
    ResetPasswordRequestModel request,
  ) async => _apiClient.resetPassword(request);
}
