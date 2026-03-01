import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../../../config/safe_api_call/safe_api_call.dart';
import '../../data/datasources/orders_remote_data_source.dart';
import '../api_client/orders_api_client.dart';
import '../../data/models/orders_response_model.dart';

@Injectable(as: OrdersRemoteDataSource)
class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final OrdersApiClient _apiClient;

  OrdersRemoteDataSourceImpl(this._apiClient);

  @override
  Future<BaseResponse<OrdersResponseModel>> getOrders() {
    return safeApiCall(() => _apiClient.getOrders());
  }
}
