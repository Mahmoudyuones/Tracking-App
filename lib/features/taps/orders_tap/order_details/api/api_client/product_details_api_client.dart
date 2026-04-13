import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../../core/constants/api_endpoints.dart';
import '../../data/models/product_details_response_model.dart';

part 'product_details_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class ProductDetailsApiClient {
  @factoryMethod
  factory ProductDetailsApiClient(Dio dio) = _ProductDetailsApiClient;

  @GET(ApiEndpoints.productDetails)
  Future<ProductDetailsResponseModel> getProductDetails(
    @Path(ApiEndpoints.idPathQuery) String productId,
  );
}
