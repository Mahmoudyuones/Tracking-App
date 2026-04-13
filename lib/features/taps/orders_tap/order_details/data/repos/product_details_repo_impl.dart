import 'package:injectable/injectable.dart';

import '../../../../../../config/base_response/base_response.dart';
import '../../domain/entities/product_details_response_entity.dart';
import '../../domain/repos/product_details_repo.dart';
import '../datasources/product_details_remote_data_source.dart';

@LazySingleton(as: ProductDetailsRepo)
class ProductDetailsRepoImpl implements ProductDetailsRepo {
  final ProductDetailsRemoteDataSource _productDetailsRemoteDataSource;

  ProductDetailsRepoImpl(this._productDetailsRemoteDataSource);

  @override
  Future<BaseResponse<ProductDetailsResponseEntity>> getProductDetails(
    String productId,
  ) async {
    final response = await _productDetailsRemoteDataSource.getProductDetails(
      productId,
    );

    return response.when(
      success: (model) => BaseResponse.success(model.toEntity()),
      failure: (failure) => BaseResponse.failure(failure),
    );
  }
}
