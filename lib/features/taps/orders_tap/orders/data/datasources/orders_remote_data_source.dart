import '../../../../../../config/base_response/base_response.dart';
import '../models/orders_response_model.dart';

abstract interface class OrdersRemoteDataSource {
  Future<BaseResponse<OrdersResponseModel>> getOrders();
}
