import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../../core/constants/api_endpoints.dart';
import '../../data/models/orders_response_model.dart';

part 'orders_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class OrdersApiClient {
  @factoryMethod
  factory OrdersApiClient(Dio dio) = _OrdersApiClient;

  @GET(ApiEndpoints.orders)
  Future<OrdersResponseModel> getOrders();
}
