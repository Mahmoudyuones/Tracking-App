import '../../../../../../config/base_response/base_response.dart';
import '../models/change_password_request_model.dart';
import '../models/change_password_response_model.dart';

abstract interface class ChangePasswordDataSource {
  Future<BaseResponse<ChangePasswordResponseModel>> changePassword(
    ChangePasswordRequestModel requestModel,
  );
}
