import '../../../../config/base_response/base_response.dart';
import '../entities/orders_entity.dart';

abstract interface class OrderRepo {
  Future<BaseResponse<List<OrdersEntity>>> getOrders();
}
