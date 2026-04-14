import 'order_item_entity.dart';
import 'store_entity.dart';
import 'user_entity.dart';

class OrderEntity {
  final String id;
  final UserEntity user;
  final List<OrderItemEntity> orderItems;
  final double totalPrice;
  final String paymentType;
  final bool isPaid;
  final bool isDelivered;
  final String state;
  final String orderNumber;
  final StoreEntity store;

  OrderEntity({
    required this.id,
    required this.user,
    required this.orderItems,
    required this.totalPrice,
    required this.paymentType,
    required this.isPaid,
    required this.isDelivered,
    required this.state,
    required this.orderNumber,
    required this.store,
  });
}
