import 'package:freezed_annotation/freezed_annotation.dart';

import 'start_order_item_model.dart';
part 'start_order_model.g.dart';

@JsonSerializable()
class StartOrderModel {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'user')
  final String userId;
  @JsonKey(name: 'orderItems')
  final List<StartOrderItemModel> orderItems;
  @JsonKey(name: 'totalPrice')
  final num totalPrice;
  @JsonKey(name: 'paymentType')
  final String paymentType;
  @JsonKey(name: 'isPaid')
  final bool isPaid;
  @JsonKey(name: 'isDelivered')
  final bool isDelivered;
  @JsonKey(name: 'state')
  final String state;
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;
  @JsonKey(name: 'orderNumber')
  final String orderNumber;
  @JsonKey(name: '__v')
  final int v;

  StartOrderModel({
    required this.id,
    required this.userId,
    required this.orderItems,
    required this.totalPrice,
    required this.paymentType,
    required this.isPaid,
    required this.isDelivered,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
    required this.orderNumber,
    required this.v,
  });

  factory StartOrderModel.fromJson(Map<String, dynamic> json) =>
      _$StartOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$StartOrderModelToJson(this);
}
