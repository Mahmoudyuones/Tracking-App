import '../../../../../config/base_response/base_response.dart';
import '../entities/response/start_order_response/start_order_response_entity.dart';

abstract interface class StartOrderRepository {
  Future<BaseResponse<StartOrderResponseEntity>> startOrder(String orderId);
}
