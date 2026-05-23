import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/constants/api_endpoints.dart';
part 'update_order_state_api_client.g.dart';

@injectable
@RestApi(baseUrl: ApiEndpoints.baseUrl)
abstract class UpdateOrderStateApiClient {
  @factoryMethod
  factory UpdateOrderStateApiClient(Dio dio) = _UpdateOrderStateApiClient;

  @PUT(ApiEndpoints.updateOrderState)
  Future<void> updateOrderState(
    @Path(ApiEndpoints.idPathQuery) String orderId,
    @Query('state') String state,
  );
}
