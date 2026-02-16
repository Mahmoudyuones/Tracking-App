import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../../core/constants/api_endpoints.dart';
import '../../data/models/request/forget_password_request_model.dart';
import '../../data/models/request/reset_password_request_model.dart';
import '../../data/models/request/verify_code_request_model.dart';
import '../../data/models/response/forget_password_response_model.dart';
import '../../data/models/response/reset_password_response_model.dart';
import '../../data/models/response/verify_code_response_model.dart';

part 'forget_password_api_client.g.dart';

@injectable
@RestApi(baseUrl: ApiEndpoints.baseUrl)
abstract class ForgetPasswordApiClient {
  @factoryMethod
  factory ForgetPasswordApiClient(Dio dio) = _ForgetPasswordApiClient;

  @POST(ApiEndpoints.forgotPassword)
  Future<ForgetPasswordResponseModel> forgetPassword(
    @Body() ForgetPasswordRequestModel request,
  );

  @POST(ApiEndpoints.verifyResetCode)
  Future<VerifyCodeResponseModel> verifyCode(
    @Body() VerifyCodeRequestModel request,
  );

  @PUT(ApiEndpoints.resetPassword)
  Future<ResetPasswordResponseModel> resetPassword(
    @Body() ResetPasswordRequestModel request,
  );
}
