import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../product/product_model.dart';

part 'order_item_model.g.dart';

@JsonSerializable()
class OrderItemModel extends Equatable {
  @JsonKey(name: 'product')
  final ProductModel? productModel;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'quantity')
  final int? quantity;
  @JsonKey(name: '_id')
  final String? id;

  const OrderItemModel({this.productModel, this.price, this.quantity, this.id});

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);

  @override
  List<Object?> get props => [productModel, price, quantity, id];
}
