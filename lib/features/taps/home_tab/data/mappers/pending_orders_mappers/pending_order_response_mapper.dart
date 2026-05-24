import '../../../domain/entities/response/pending_orders_response/pending_order_response_entity.dart';
import '../../models/response/pending_order_response/pending_order_response_model.dart';
import 'meta_data_pending_order_mapper.dart';
import 'order_mapper.dart';

extension PendingOrderResponseMapper on PendingOrderResponseModel {
  PendingOrderResponseEntity toEntity() {
    return PendingOrderResponseEntity(
      message: message,
      metadata: metadata.toEntity(),
      orders: orders
          .where(
            (order) =>
                order.user != null &&
                order.orderItems.every((item) => item.product != null),
          )
          .map((e) => e.toEntity())
          .toList(),
    );
  }
}
