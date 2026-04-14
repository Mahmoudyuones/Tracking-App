import 'product_entity.dart';

class OrderItemEntity {
  final String id;
  final ProductEntity product;
  final double price;
  final int quantity;

  OrderItemEntity({
    required this.id,
    required this.product,
    required this.price,
    required this.quantity,
  });
}
