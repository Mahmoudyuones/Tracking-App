import 'product_order_entity.dart';

class ProductDetailsResponseEntity {
  final ProductOrderEntity? product;

  const ProductDetailsResponseEntity({this.product});

  factory ProductDetailsResponseEntity.empty() =>
      const ProductDetailsResponseEntity(product: null);
}
