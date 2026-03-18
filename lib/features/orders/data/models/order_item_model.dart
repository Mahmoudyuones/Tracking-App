import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/order_item_entity.dart';
import 'product_model.dart';

part 'order_item_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderItemModel {
  @JsonKey(name: 'product')
  final ProductModel? product;

  @JsonKey(name: 'price')
  final num? price;

  @JsonKey(name: 'quantity')
  final int? quantity;

  @JsonKey(name: '_id')
  final String? id;

  OrderItemModel({this.product, this.price, this.quantity, this.id});

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);

  OrderItemEntity toEntity() => OrderItemEntity(
    product: product?.toEntity(),
    price: price,
    quantity: quantity,
    id: id,
  );
}
