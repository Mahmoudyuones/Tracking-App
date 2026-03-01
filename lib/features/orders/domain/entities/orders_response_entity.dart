import 'orders_metadata_entity.dart';
import 'order_wrapper_entity.dart';

class OrdersResponseEntity {
  final String? message;
  final OrdersMetadataEntity? metadata;
  final List<OrderWrapperEntity>? orders;

  const OrdersResponseEntity({this.message, this.metadata, this.orders});
}
