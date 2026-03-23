import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../data_sources/remote/firebase/remote_track_order_firebase_data_source.dart';
import '../../data/models/order_tracking_firebase_model.dart';
import '../../domain/entities/update_order_state_request_entity.dart';
import '../../domain/repo/track_order_repo.dart';
import '../data_sources/remote/apis/remote_track_order_api_data_source.dart';
import '../mappers/track_order_mappers.dart';

@Injectable(as: TrackOrderRepo)
class TrackOrderRepoImpl implements TrackOrderRepo {
  final TrackOrderFirebaseDataSource _firebaseDataSource;
  final RemoteTrackOrderApiDataSource _trackOrderDataSource;

  TrackOrderRepoImpl(this._firebaseDataSource, this._trackOrderDataSource);

  @override
  Future<BaseResponse<void>> saveOrderToFirebase(
    OrderTrackingFirebaseModel orderTracking,
  ) async {
    return await _firebaseDataSource.saveOrderToFirebase(orderTracking);
  }

  @override
  Future<BaseResponse<void>> updateOrderStateFirebase({
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

  @override
  Future<BaseResponse<void>> updateOrderStateApi(
    UpdateOrderStateRequestEntity requestEntity,
    String orderId,
  ) async {
    final response = await _trackOrderDataSource.updateOrderState(
      orderId,
      requestEntity.toModel(),
    );
    return response.when(
      success: (data) {
        return const BaseResponse<void>.success(null);
      },
      failure: (failure) {
        return BaseResponse<void>.failure(failure);
      },
    );
  }

  @override
  Future<BaseResponse<void>> updateOrderState(
    String orderId,
    String state,
    UpdateOrderStateRequestEntity requestEntity,
  ) async {
    // 1. Update API first
    final apiResult = await updateOrderStateApi(requestEntity, orderId);

    // 2. If API failed, return failure immediately
    return await apiResult.when(
      success: (_) async {
        // 3. API succeeded, now update Firebase
        return await updateOrderStateFirebase(orderId: orderId, state: state);
      },
      failure: (exception) {
        // 4. API failed, return the failure
        return BaseResponse.failure(exception);
      },
    );
  }
}
