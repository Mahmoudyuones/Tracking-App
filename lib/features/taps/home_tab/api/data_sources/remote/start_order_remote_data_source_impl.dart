import 'package:injectable/injectable.dart';

import '../../../../../../config/base_response/base_response.dart';
import '../../../../../../config/safe_api_call/safe_api_call.dart';
import '../../../../../../core/helpers/firebase/fire_base_services.dart';
import '../../../../../../core/helpers/firebase/fire_store_ref_key.dart';
import '../../../../../../core/shared/models/order_details_model.dart';
import '../../../data/datasources/remote/start_order_remote_data_source.dart';
import '../../../data/models/response/start_order_response/start_order_response_model.dart';
import '../../api_clients/home_api_client.dart';

@Injectable(as: StartOrderRemoteDataSource)
class StartOrderRemoteDataSourceImpl implements StartOrderRemoteDataSource {
  StartOrderRemoteDataSourceImpl(this._homeApiClient, this._fireService);
  final HomeApiClient _homeApiClient;
  final FireStoreService _fireService;

  @override
  Future<BaseResponse<StartOrderResponseModel>> startOrder(
    String orderId,
  ) async {
    return await safeApiCall(() => _homeApiClient.startOrder(orderId));
  }

  @override
  Future<BaseResponse<void>> addOrderDetails({
    required OrderDetailsModel orderDetails,
  }) async {
    return safeApiCall(() async {
      final orderDetailsJson = orderDetails.toJson();
      return await _fireService.fireStore
          .collection(FireStoreRefKey.users)
          .doc(orderDetails.orders.user.id)
          .collection(FireStoreRefKey.orders)
          .doc(orderDetails.orders.id)
          .set(orderDetailsJson);
    });
  }
}
