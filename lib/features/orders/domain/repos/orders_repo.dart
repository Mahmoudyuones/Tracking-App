import '../../../../config/base_response/base_response.dart';
import '../entities/orders_response_entity.dart';

abstract interface class OrdersRepo {
  Future<BaseResponse<OrdersResponseEntity>> getOrders();
}
