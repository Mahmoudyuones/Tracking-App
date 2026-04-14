import '../../../../../config/base_response/base_response.dart';
import '../entities/response/pending_orders_response/pending_order_response_entity.dart';

abstract interface class PendingOrdersRepository {
  Future<BaseResponse<PendingOrderResponseEntity>> getPendingOrders({
    int limit,
  });
}
