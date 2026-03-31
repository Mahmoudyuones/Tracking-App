import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../../../config/safe_api_call/safe_api_call.dart';
import '../../data/datasources/product_details_remote_data_source.dart';
import '../../data/models/product_details_response_model.dart';
import '../api_client/product_details_api_client.dart';

@LazySingleton(as: ProductDetailsRemoteDataSource)
class ProductDetailsRemoteDataSourceImpl
    implements ProductDetailsRemoteDataSource {
  final ProductDetailsApiClient _productDetailsApiClient;

  ProductDetailsRemoteDataSourceImpl(this._productDetailsApiClient);

  @override
  Future<BaseResponse<ProductDetailsResponseModel>> getProductDetails(
    String productId,
  ) => safeApiCall(() => _productDetailsApiClient.getProductDetails(productId));
}
