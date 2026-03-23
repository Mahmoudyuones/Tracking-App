import '../../../../../../config/base_response/base_response.dart';
import '../../models/request/apply_request_model/apply_request_model.dart';
import '../../models/response/apply_response_model/apply_response_model.dart';

abstract interface class ApplyRemoteDataSource {
  Future<BaseResponse<ApplyResponseModel>> applyDriver(
    ApplyRequestModel request,
  );
}
