import '../../../../../config/base_response/base_response.dart';
import '../../../../../core/shared/models/location_model.dart';
import '../../../../../core/shared/models/order_details_model.dart';

abstract interface class UpdateOrderStateRemoteDataSource {
  Stream<BaseResponse<OrderDetailsModel>> getOrderByOrderId({
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
  Future<BaseResponse<void>> updateLocation({
    required String orderId,
    required String userId,
    required LocationModel location,
  });
}
