import 'start_order_item_entity.dart';

class StartOrderEntity {
  final String id;
  final String userId;
  final List<StartOrderItemEntity> orderItems;
  final num totalPrice;
  final String paymentType;
  final bool isPaid;
  final bool isDelivered;
  final String status;

  StartOrderEntity({
    required this.id,
    required this.userId,
    required this.orderItems,
    required this.totalPrice,
    required this.paymentType,
    required this.isPaid,
    required this.isDelivered,
    required this.status,
  });
}
