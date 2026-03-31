import 'package:injectable/injectable.dart';
import '../../../../config/base_response/base_response.dart';
import '../../../../config/exception/app_exception.dart';
import '../entities/product_details_response_entity.dart';
import '../repos/product_details_repo.dart';

@injectable
class GetMultipleProductDetailsUseCase {
  final ProductDetailsRepo _productDetailsRepo;

  GetMultipleProductDetailsUseCase(this._productDetailsRepo);

  Future<
    ({List<ProductDetailsResponseEntity> products, List<AppException> failures})
  >
  call(List<String> productIds) async {
    final results = await Future.wait(
      productIds.map((id) => _productDetailsRepo.getProductDetails(id)),
    );

    final products = <ProductDetailsResponseEntity>[];
    final failures = <AppException>[];

    for (final result in results) {
      result.when(
        success: (entity) => products.add(entity),
        failure: (failure) => failures.add(failure),
      );
    }

    return (products: products, failures: failures);
  }
}
