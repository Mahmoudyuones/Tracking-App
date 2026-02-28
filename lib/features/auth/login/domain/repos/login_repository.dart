import '../../../../../config/base_response/base_response.dart';
import '../../data/models/login_request_model/login_request_model.dart';
import '../../data/models/login_response_model/login_response_model.dart';

abstract interface class LoginRepository {
  Future<BaseResponse<LoginResponseModel>> login({
    required LoginRequestModel request,
    bool remembered = false,
  });
}
