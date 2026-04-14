import '../../domain/entities/response/pending_orders_response/order_entity.dart';
import '../models/response/pending_order_response/order_model.dart';
import 'order_item_mapper.dart';
import 'store_mapper.dart';
import 'user_mapper.dart';

extension OrderMapper on OrderModel {
  OrderEntity toEntity() {
    return OrderEntity(
      id: id,
      totalPrice: totalPrice.toDouble(),
      orderItems: orderItems.map((item) => item.toEntity()).toList(),
      user: user.toEntity(),
      paymentType: paymentType,
      isPaid: isPaid,
      isDelivered: isDelivered,
      state: state,
      orderNumber: orderNumber,
      store: store.toEntity(),
    );
  }
}
