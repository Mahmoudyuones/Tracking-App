import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../order_item/order_item_model.dart';
import '../user/user_model.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'user')
  final UserModel? userModel;
  @JsonKey(name: 'orderItems')
  final List<OrderItemModel>? orderItemsModel;
  @JsonKey(name: 'totalPrice')
  final int? totalPrice;
  @JsonKey(name: 'paymentType')
  final String? paymentType;
  @JsonKey(name: 'isPaid')
  final bool? isPaid;
  @JsonKey(name: 'isDelivered')
  final bool? isDelivered;
  @JsonKey(name: 'state')
  final String? state;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;
  @JsonKey(name: 'orderNumber')
  final String? orderNumber;
  @JsonKey(name: '__v')
  final int? v;

  const OrderModel(
    this.id,
    this.userModel,
    this.orderItemsModel,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
    this.v,
  );

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  @override
  List<Object?> get props => [
    id,
    userModel,
    orderItemsModel,
    totalPrice,
    paymentType,
    isPaid,
    isDelivered,
    state,
    createdAt,
    updatedAt,
    orderNumber,
    v,
  ];
}
