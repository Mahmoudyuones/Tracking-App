import 'order_entity.dart';
import 'store_entity.dart';

class OrderWrapperEntity {
  final String? id;
  final String? driver;
  final OrderEntity? order;
  final int? v;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final StoreEntity? store;

  const OrderWrapperEntity({
    this.id,
    this.driver,
    this.order,
    this.v,
    this.createdAt,
    this.updatedAt,
    this.store,
  });
}
