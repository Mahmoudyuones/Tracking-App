import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../data/models/update_order_state_request_model.dart';
import '../../data/models/update_order_state_response_model.dart';
part 'track_order_api_client.g.dart';

@injectable
@RestApi(baseUrl: ApiEndpoints.baseUrl)
abstract class TrackOrderApiClient {
  @factoryMethod
  factory TrackOrderApiClient(Dio dio) = _TrackOrderApiClient;

  @PUT(ApiEndpoints.updateOrderState)
  Future<UpdateOrderStateResponseModel> updateOrderState(
    @Path(ApiEndpoints.idPathQuery) String orderId,
    @Body() UpdateOrderStateRequestModel requestModel,
  );
}
