import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../order/order_model.dart';
import '../store/store_model.dart';

part 'orders_model.g.dart';

/// [OrdersModel] class for get all driver orders => https://flower.elevateegy.com/api/v1/orders/driver-orders
/// [OrderModel.id] for begin Start order, send to backend => https://flower.elevateegy.com/api/v1/orders/start/678a9bb63745562ff48ce07b
@JsonSerializable()
class OrdersModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'driver')
  final String? driverId;
  @JsonKey(name: 'order')
  final OrderModel? orderModel;
  @JsonKey(name: '__v')
  final int? v;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;
  @JsonKey(name: 'store')
  final StoreModel? store;

  // @JsonKey(name: 'shippingAddress')
  // final ShippingAddressModel? shippingAddressModel;
  // @JsonKey(name: 'paidAt')
  // final DateTime? paidAt;

  const OrdersModel({
    this.id,
    this.driverId,
    this.orderModel,
    this.v,
    this.createdAt,
    this.updatedAt,
    this.store,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) =>
      _$OrdersModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersModelToJson(this);

  @override
  List<Object?> get props => [
    id,
    driverId,
    orderModel,
    v,
    createdAt,
    updatedAt,
    store,
  ];
}
