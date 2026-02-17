import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../metadata/metadata.dart';
import '../orders/orders_model.dart';

part 'base_order_response_model.g.dart';

@JsonSerializable()
class BaseOrderResponseModel extends Equatable {
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'metadata')
  final Metadata? metadata;
  @JsonKey(name: 'orders')
  final List<OrdersModel>? ordersModel;

  const BaseOrderResponseModel({this.message, this.metadata, this.ordersModel});

  factory BaseOrderResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BaseOrderResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BaseOrderResponseModelToJson(this);

  @override
  List<Object?> get props => [message, metadata, ordersModel];
}

@JsonSerializable()
class ShippingAddressModel extends Equatable {
  @JsonKey(name: 'street')
  final String? street;
  @JsonKey(name: 'city')
  final String? city;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'lat')
  final String? lat;
  @JsonKey(name: 'long')
  final String? long;

  const ShippingAddressModel({
    this.street,
    this.city,
    this.phone,
    this.lat,
    this.long,
  });

  factory ShippingAddressModel.fromJson(Map<String, dynamic> json) =>
      _$ShippingAddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingAddressModelToJson(this);

  @override
  List<Object?> get props => [street, city, phone, lat, long];
}
