import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/base_response/base_response.dart';
import '../../../../config/exception/server_exception.dart';
import '../../../../config/safe_api_call/safe_api_call.dart';
import '../../../../core/constants/app_text_string.dart';
import '../../../../core/helpers/firebase/fire_base_services.dart';
import '../../../../core/helpers/firebase/fire_store_ref_key.dart';
import '../../../../core/shared/models/order_details_model.dart';
import '../../data/datasources/remote/update_order_state_remote_data_source.dart';
import '../api_client/update_order_state_api_client.dart';

@Injectable(as: UpdateOrderStateRemoteDataSource)
class UpdateOrderStateRemoteDataSourceImpl
    implements UpdateOrderStateRemoteDataSource {
  final UpdateOrderStateApiClient _apiClient;
  final FireStoreService _fireService;
  UpdateOrderStateRemoteDataSourceImpl(this._apiClient, this._fireService);

  @override
  Stream<BaseResponse<OrderDetailsModel>> getOrderByOrderId({
    required String userId,
    required String orderId,
  }) {
    return _fireService.fireStore
        .collection(FireStoreRefKey.users)
        .doc(userId)
        .collection(FireStoreRefKey.orders)
        .doc(orderId)
        .snapshots()
        .asyncMap(
          (orderDetails) => safeApiCall(() async {
            if (!orderDetails.exists || orderDetails.data() == null) {
              throw ServerException(
                message: AppTextString.orderNotFound,
                statusCode: 404,
              );
            }

            final data = orderDetails.data() as Map<String, dynamic>;
            return OrderDetailsModel.fromJson(data);
          }),
        );
  }

  @override
  Future<BaseResponse<void>> updateOrderStatusInFirestore({
    required String userId,
    required String orderId,
    required String status,
  }) {
    return safeApiCall(() async {
      if (Firebase.apps.isEmpty) {
        Firebase.initializeApp();
      }

      return await _fireService.fireStore
          .collection(FireStoreRefKey.users)
          .doc(userId)
          .collection(FireStoreRefKey.orders)
          .doc(orderId)
          .update({FireStoreRefKey.state: status});
    });
  }

  @override
  Future<BaseResponse<void>> changeOrderStatus({
    required String orderId,
    required String state,
  }) {
    return safeApiCall(
      () => _apiClient.updateOrderState(orderId, {'state': state}),
    );
  }
}
