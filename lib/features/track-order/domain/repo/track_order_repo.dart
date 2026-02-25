import '../../../../../../config/base_response/base_response.dart';
import '../../data/models/order_tracking_firebase_model.dart';

abstract interface class TrackOrderRepo {
  Future<BaseResponse<void>> saveOrderToFirebase(
    OrderTrackingFirebaseModel orderTracking,
  );
  Future<BaseResponse<void>> updateOrderState({
    required String orderId,
    required String state,
  });
  Future<BaseResponse<OrderTrackingFirebaseModel?>> getOrderTracking(
    String orderId,
  );
}
