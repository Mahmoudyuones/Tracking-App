import '../../../domain/entities/response/start_order_response/start_order_entity.dart';
import '../../models/response/start_order_response/start_order_model.dart';
import 'start_order_item_mapper.dart';

extension StartOrderMapper on StartOrderModel {
  StartOrderEntity toEntity() {
    return StartOrderEntity(
      id: id,
      userId: userId,
      orderItems: orderItems.map((e) => e.toEntity()).toList(),
      totalPrice: totalPrice,
      paymentType: paymentType,
      isPaid: isPaid,
      isDelivered: isDelivered,
      status: state,
      orderNumber: orderNumber,
    );
  }
}
