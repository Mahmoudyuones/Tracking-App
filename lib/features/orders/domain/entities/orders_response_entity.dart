import 'orders_metadata_entity.dart';
import 'order_wrapper_entity.dart';

class OrdersResponseEntity {
  final String? message;
  final OrdersMetadataEntity? metadata;
  final List<OrderWrapperEntity>? orders;
  final int completedCount;
  final int cancelledCount;

  const OrdersResponseEntity({
    this.message,
    this.metadata,
    this.orders,
    this.completedCount = 0,
    this.cancelledCount = 0,
  });
}
