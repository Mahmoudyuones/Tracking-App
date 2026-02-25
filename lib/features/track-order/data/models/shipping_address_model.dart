import 'package:freezed_annotation/freezed_annotation.dart';

part 'shipping_address_model.g.dart';

@JsonSerializable()
class ShippingAddressModel {
  final String street;
  final String city;
  final String phone;
  final String lat;
  final String long;

  ShippingAddressModel({
    required this.street,
    required this.city,
    required this.phone,
    required this.lat,
    required this.long,
  });

  factory ShippingAddressModel.fromJson(Map<String, dynamic> json) =>
      _$ShippingAddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingAddressModelToJson(this);
}
