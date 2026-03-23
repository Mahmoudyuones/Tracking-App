import '../../../../../config/base_response/base_response.dart';
import '../entities/request/apply_request_entity.dart';

abstract interface class ApplyRepository {
  Future<BaseResponse<String>> apply(ApplyRequestEntity applyRequestEntity);
}
