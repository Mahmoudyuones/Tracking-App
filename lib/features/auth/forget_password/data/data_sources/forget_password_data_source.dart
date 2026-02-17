import '../models/request/forget_password_request_model.dart';
import '../models/request/reset_password_request_model.dart';
import '../models/request/verify_code_request_model.dart';
import '../models/response/forget_password_response_model.dart';
import '../models/response/reset_password_response_model.dart';
import '../models/response/verify_code_response_model.dart';

abstract class ForgetPasswordDataSource {
  Future<ForgetPasswordResponseModel> forgetPassword(
    ForgetPasswordRequestModel request,
  );

  Future<VerifyCodeResponseModel> verifyCode(VerifyCodeRequestModel request);

  Future<ResetPasswordResponseModel> resetPassword(
    ResetPasswordRequestModel request,
  );
}
