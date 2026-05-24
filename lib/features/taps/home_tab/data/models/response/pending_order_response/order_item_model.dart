import 'package:freezed_annotation/freezed_annotation.dart';
import 'product_model.dart';
part 'order_item_model.g.dart';

@JsonSerializable()
class OrderItemModel {
  @JsonKey(name: 'product')
  final ProductModel? product;
  @JsonKey(name: 'price')
  final int price;
  @JsonKey(name: 'quantity')
  final int quantity;
  @JsonKey(name: '_id')
  final String id;

  OrderItemModel({
    this.product,
    required this.price,
    required this.quantity,
    required this.id,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);
}
