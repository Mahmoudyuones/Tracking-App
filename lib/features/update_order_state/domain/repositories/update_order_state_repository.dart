import '../../../../config/base_response/base_response.dart';
import '../../../../core/shared/entities/order_details_entity.dart';

abstract interface class UpdateOrderStateRepository {
  Stream<BaseResponse<OrderDetailsEntity>> getOrderByOrderId({
    required String userId,
    required String orderId,
  });
  Future<BaseResponse<void>> updateOrderStatusInFirestore({
    required String userId,
    required String orderId,
    required String status,
  });
  Future<BaseResponse<void>> changeOrderStatus({
    required String orderId,
    required String state,
  });
}
