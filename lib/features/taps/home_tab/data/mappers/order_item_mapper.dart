import '../../domain/entities/response/pending_orders_response/order_item_entity.dart';
import '../models/response/pending_order_response/order_item_model.dart';
import 'product_mapper.dart';

extension OrderItemMapper on OrderItemModel {
  OrderItemEntity toEntity() {
    return OrderItemEntity(
      id: id,
      product: product.toEntity(),
      price: price.toDouble(),
      quantity: quantity,
    );
  }
}
