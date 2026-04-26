import 'order_entity.dart';
import 'meta_data_pending_order_entity.dart';

class PendingOrderResponseEntity {
  final String message;
  final List<OrderEntity> orders;
  final MetaDataPendingOrderEntity metadata;

  PendingOrderResponseEntity({
    required this.message,
    required this.orders,
    required this.metadata,
  });
}
