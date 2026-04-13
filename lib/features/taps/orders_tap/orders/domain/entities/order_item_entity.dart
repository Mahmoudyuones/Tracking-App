import 'product_entity.dart';

class OrderItemEntity {
  final ProductEntity? product;
  final num? price;
  final int? quantity;
  final String? id;

  const OrderItemEntity({this.product, this.price, this.quantity, this.id});
}
