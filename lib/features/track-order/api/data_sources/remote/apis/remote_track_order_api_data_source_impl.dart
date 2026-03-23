import 'package:injectable/injectable.dart';

import '../../../../../../config/base_response/base_response.dart';
import '../../../../../../config/safe_api_call/safe_api_call.dart';
import '../../../../data/data_sources/remote/apis/remote_track_order_api_data_source.dart';
import '../../../../data/models/update_order_state_request_model.dart';
import '../../../../data/models/update_order_state_response_model.dart';
import '../../../api_client/track_order_api_client.dart';

@Injectable(as: RemoteTrackOrderApiDataSource)
class RemoteTrackOrderApiDataSourceImpl
    implements RemoteTrackOrderApiDataSource {
  final TrackOrderApiClient _apiClient;
  RemoteTrackOrderApiDataSourceImpl(this._apiClient);
  @override
  Future<BaseResponse<UpdateOrderStateResponseModel>> updateOrderState(
    String orderId,
    UpdateOrderStateRequestModel requestModel,
  ) {
    return safeApiCall(
      () => _apiClient.updateOrderState(orderId, requestModel),
    );
  }
}
