import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/order_entity.dart';
import 'user_model.dart';
import 'order_item_model.dart';

part 'order_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderModel {
  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'user')
  final UserModel? user;

  @JsonKey(name: 'orderItems')
  final List<OrderItemModel>? orderItems;

  @JsonKey(name: 'totalPrice')
  final num? totalPrice;

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

  OrderModel({
    this.id,
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
    this.v,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  OrderEntity toEntity() => OrderEntity(
    id: id,
    user: user?.toEntity(),
    orderItems: orderItems?.map((e) => e.toEntity()).toList(),
    totalPrice: totalPrice,
    paymentType: paymentType,
    isPaid: isPaid,
    isDelivered: isDelivered,
    state: state,
    createdAt: createdAt,
    updatedAt: updatedAt,
    orderNumber: orderNumber,
    v: v,
  );
}
