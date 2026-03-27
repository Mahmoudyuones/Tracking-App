import '../../../../config/base_response/base_response.dart';
import '../entities/product_details_response_entity.dart';

abstract interface class ProductDetailsRepo {
  Future<BaseResponse<ProductDetailsResponseEntity>> getProductDetails(
    String productId,
  );
}
