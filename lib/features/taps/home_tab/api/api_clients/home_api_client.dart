import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../../core/constants/api_endpoints.dart';
import '../../data/models/response/pending_order_response/pending_order_response_model.dart';
part 'home_api_client.g.dart';

@injectable
@RestApi(baseUrl: ApiEndpoints.baseUrl)
abstract class HomeApiClient {
  @factoryMethod
  factory HomeApiClient(Dio dio) = _HomeApiClient;

  @GET(ApiEndpoints.orders)
  Future<PendingOrderResponseModel> getPendingOrders({
    @Query('limit') int limit,
  });
}
