import '../../../../../../config/base_response/base_response.dart';
import '../../data/models/order_tracking_firebase_model.dart';
import '../entities/update_order_state_request_entity.dart';

abstract interface class TrackOrderRepo {
  Future<BaseResponse<void>> saveOrderToFirebase(
    OrderTrackingFirebaseModel orderTracking,
  );
  Future<BaseResponse<void>> updateOrderStateFirebase({
    required String orderId,
    required String state,
  });
  Future<BaseResponse<OrderTrackingFirebaseModel?>> getOrderTracking(
    String orderId,
  );
  Future<BaseResponse<void>> updateOrderStateApi(
    UpdateOrderStateRequestEntity requestEntity,
    String orderId,
  );
  Future<BaseResponse<void>> updateOrderState(
    String orderId,
    String state,
    UpdateOrderStateRequestEntity requestEntity,
  );
}
