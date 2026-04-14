import '../../../../../../config/base_state/base_state.dart';
import '../../domain/entities/product_details_response_entity.dart';

class ProductDetailsState {
  final BaseState<List<ProductDetailsResponseEntity>> productDetailsState;

  ProductDetailsState({required this.productDetailsState});

  ProductDetailsState copyWith({
    BaseState<List<ProductDetailsResponseEntity>>? productDetailsState,
  }) {
    return ProductDetailsState(
      productDetailsState: productDetailsState ?? this.productDetailsState,
    );
  }
}
