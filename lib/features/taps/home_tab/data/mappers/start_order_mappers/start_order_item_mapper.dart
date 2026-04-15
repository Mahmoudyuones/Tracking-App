import '../../../domain/entities/response/start_order_response/start_order_item_entity.dart';
import '../../models/response/start_order_response/start_order_item_model.dart';

extension StartOrderItemMapper on StartOrderItemModel {
  StartOrderItemEntity toEntity() {
    return StartOrderItemEntity(
      orderItemId: orderItemId,
      productId: productId,
      quantity: quantity,
      price: price,
    );
  }
}
