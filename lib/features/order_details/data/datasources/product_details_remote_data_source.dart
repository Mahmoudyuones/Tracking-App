import '../../../../config/base_response/base_response.dart';
import '../models/product_details_response_model.dart';

abstract interface class ProductDetailsRemoteDataSource {
  Future<BaseResponse<ProductDetailsResponseModel>> getProductDetails(
    String productId,
  );
}
