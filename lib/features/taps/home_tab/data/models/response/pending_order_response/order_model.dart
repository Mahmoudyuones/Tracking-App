import 'package:freezed_annotation/freezed_annotation.dart';

import 'order_item_model.dart';
import 'store_model.dart';
import 'user_model.dart';
part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'user')
  final UserModel user;
  @JsonKey(name: 'orderItems')
  final List<OrderItemModel> orderItems;
  @JsonKey(name: 'totalPrice')
  final int totalPrice;
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
  @JsonKey(name: 'store')
  final StoreModel store;

  OrderModel({
    required this.id,
    required this.user,
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
    required this.store,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
