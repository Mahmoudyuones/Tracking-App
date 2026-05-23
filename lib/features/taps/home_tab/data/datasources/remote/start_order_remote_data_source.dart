import '../../../../../../config/base_response/base_response.dart';
import '../../../../../../core/shared/models/order_details_model.dart';
import '../../models/response/start_order_response/start_order_response_model.dart';

abstract interface class StartOrderRemoteDataSource {
  Future<BaseResponse<StartOrderResponseModel>> startOrder(String orderId);
  Future<BaseResponse<void>> addOrderDetails({
    required OrderDetailsModel orderDetails,
  });
}
