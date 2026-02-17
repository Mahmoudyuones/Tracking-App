import 'package:injectable/injectable.dart';
import '../../../../../config/base_response/base_response.dart';
import '../../../../../config/safe_api_call/safe_api_call.dart';
import '../../domain/repository/forget_password_repository.dart';
import '../data_sources/forget_password_data_source.dart';
import '../models/request/forget_password_request_model.dart';
import '../models/request/reset_password_request_model.dart';
import '../models/request/verify_code_request_model.dart';

@Injectable(as: ForgetPasswordRepository)
class ForgetPasswordRepositoryImpl implements ForgetPasswordRepository {
  final ForgetPasswordDataSource _dataSource;

  ForgetPasswordRepositoryImpl(this._dataSource);
  @override
  Future<BaseResponse<void>> forgetPassword(
    ForgetPasswordRequestModel request,
  ) async {
    return safeApiCall<void>(() async {
      await _dataSource.forgetPassword(request);
    });
  }

  @override
  Future<BaseResponse<void>> verifyCode(VerifyCodeRequestModel request) async {
    return safeApiCall<void>(() async {
      await _dataSource.verifyCode(request);
    });
  }

  @override
  Future<BaseResponse<void>> resetCode(ResetPasswordRequestModel request) {
    return safeApiCall<void>(() async {
      await _dataSource.resetPassword(request);
    });
  }
}
