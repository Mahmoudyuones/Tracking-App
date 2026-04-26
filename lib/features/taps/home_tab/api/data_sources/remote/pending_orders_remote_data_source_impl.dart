import 'package:injectable/injectable.dart';

import '../../../../../../config/base_response/base_response.dart';
import '../../../../../../config/safe_api_call/safe_api_call.dart';
import '../../../data/datasources/remote/pending_orders_remote_data_source.dart';
import '../../../data/models/response/pending_order_response/pending_order_response_model.dart';
import '../../api_clients/home_api_client.dart';

@Injectable(as: PendingOrdersRemoteDataSource)
class PendingOrdersRemoteDataSourceImpl
    implements PendingOrdersRemoteDataSource {
  final HomeApiClient _homeApiClient;

  PendingOrdersRemoteDataSourceImpl(this._homeApiClient);

  @override
  Future<BaseResponse<PendingOrderResponseModel>> getPendingOrders({
    int? limit,
    required int page,
  }) {
    return safeApiCall(
      () => _homeApiClient.getPendingOrders(limit: limit, page: page),
    );
  }
}
