import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../config/base_response/base_response.dart';
import '../../../../../../config/exception/firebase_exception.dart';
import '../../../../data/data_sources/remote/firebase/track_order_firebase_data_source.dart';
import '../../../../data/models/order_tracking_firebase_model.dart';

@Injectable(as: TrackOrderFirebaseDataSource)
class TrackOrderFirebaseDataSourceImpl implements TrackOrderFirebaseDataSource {
  final FirebaseFirestore _firestore;

  TrackOrderFirebaseDataSourceImpl(this._firestore);

  @override
  Future<BaseResponse<void>> saveOrderToFirebase(
    OrderTrackingFirebaseModel orderTracking,
  ) async {
    try {
      await _firestore
          .collection('orders_tracking')
          .doc(orderTracking.orderId)
          .set(orderTracking.toJson());

      return const BaseResponse.success(null);
    } on FirebaseException catch (e) {
      return BaseResponse.failure(
        FirebaseCustomException(
          message: e.message ?? 'Failed to save order to Firebase',
        ),
      );
    } catch (e) {
      return BaseResponse.failure(
        FirebaseCustomException(message: 'Failed to save order to Firebase'),
      );
    }
  }

  @override
  Future<BaseResponse<void>> updateOrderState({
    required String orderId,
    required String state,
  }) async {
    try {
      await _firestore.collection('orders_tracking').doc(orderId).update({
        'state': state,
      });

      return const BaseResponse.success(null);
    } on FirebaseException catch (e) {
      return BaseResponse.failure(
        FirebaseCustomException(
          message: e.message ?? 'Failed to update order state to Firebase',
        ),
      );
    } catch (e) {
      return BaseResponse.failure(
        FirebaseCustomException(
          message: 'Failed to update order state to Firebase',
        ),
      );
    }
  }

  @override
  Future<BaseResponse<OrderTrackingFirebaseModel?>> getOrderTracking(
    String orderId,
  ) async {
    try {
      final doc = await _firestore
          .collection('orders_tracking')
          .doc(orderId)
          .get();

      if (!doc.exists) {
        return const BaseResponse.success(null);
      }

      final orderTracking = OrderTrackingFirebaseModel.fromFirestore(doc);
      return BaseResponse.success(orderTracking);
    } on FirebaseException catch (e) {
      return BaseResponse.failure(
        FirebaseCustomException(
          message: e.message ?? 'Failed to get order tracking from Firebase',
        ),
      );
    } catch (e) {
      return BaseResponse.failure(
        FirebaseCustomException(
          message: 'Failed to get order tracking from Firebase',
        ),
      );
    }
  }
}
