import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_item_model.g.dart';

@JsonSerializable()
class OrderItemModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? product;
  final num? price;
  final int? quantity;

  OrderItemModel({this.id, this.product, this.price, this.quantity});

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);
}
