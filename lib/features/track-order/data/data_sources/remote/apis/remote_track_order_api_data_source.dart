import '../../../../../../config/base_response/base_response.dart';
import '../../../models/update_order_state_request_model.dart';
import '../../../models/update_order_state_response_model.dart';

abstract interface class RemoteTrackOrderApiDataSource {
  Future<BaseResponse<UpdateOrderStateResponseModel>> updateOrderState(
    String orderId,
    UpdateOrderStateRequestModel requestModel,
  );
}
