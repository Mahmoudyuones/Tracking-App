import '../../../../../../config/base_response/base_response.dart';
import '../../models/response/start_order_response/start_order_response_model.dart';

abstract interface class StartOrderRemoteDataSource {
  Future<BaseResponse<StartOrderResponseModel>> startOrder(String orderId);
}
