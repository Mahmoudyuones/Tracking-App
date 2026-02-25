import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../data/data_sources/remote/firebase/track_order_firebase_data_source.dart';
import '../../data/models/order_tracking_firebase_model.dart';
import '../../domain/repo/track_order_repo.dart';

@Injectable(as: TrackOrderRepo)
class TrackOrderRepoImpl implements TrackOrderRepo {
  final TrackOrderFirebaseDataSource _firebaseDataSource;

  TrackOrderRepoImpl(this._firebaseDataSource);

  @override
  Future<BaseResponse<void>> saveOrderToFirebase(
    OrderTrackingFirebaseModel orderTracking,
  ) async {
    return await _firebaseDataSource.saveOrderToFirebase(orderTracking);
  }

  @override
  Future<BaseResponse<void>> updateOrderState({
    required String orderId,
    required String state,
  }) async {
    return await _firebaseDataSource.updateOrderState(
      orderId: orderId,
      state: state,
    );
  }

  @override
  Future<BaseResponse<OrderTrackingFirebaseModel?>> getOrderTracking(
    String orderId,
  ) async {
    return await _firebaseDataSource.getOrderTracking(orderId);
  }
}
