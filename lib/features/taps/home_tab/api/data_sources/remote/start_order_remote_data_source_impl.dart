import 'package:injectable/injectable.dart';

import '../../../../../../config/base_response/base_response.dart';
import '../../../../../../config/safe_api_call/safe_api_call.dart';
import '../../../data/datasources/remote/start_order_remote_data_source.dart';
import '../../../data/models/response/start_order_response/start_order_response_model.dart';
import '../../api_clients/home_api_client.dart';

@Injectable(as: StartOrderRemoteDataSource)
class StartOrderRemoteDataSourceImpl implements StartOrderRemoteDataSource {
  StartOrderRemoteDataSourceImpl(this._homeApiClient);
  final HomeApiClient _homeApiClient;

  @override
  Future<BaseResponse<StartOrderResponseModel>> startOrder(
    String orderId,
  ) async {
    return await safeApiCall(() => _homeApiClient.startOrder(orderId));
  }
}
