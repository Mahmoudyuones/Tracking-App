import '../../../../../config/base_response/base_response.dart';
import '../../data/models/request/forget_password_request_model.dart';
import '../../data/models/request/reset_password_request_model.dart';
import '../../data/models/request/verify_code_request_model.dart';

abstract class ForgetPasswordRepository {
  Future<BaseResponse<void>> forgetPassword(ForgetPasswordRequestModel request);

  Future<BaseResponse<void>> verifyCode(VerifyCodeRequestModel request);

  Future<BaseResponse<void>> resetCode(ResetPasswordRequestModel request);
}
