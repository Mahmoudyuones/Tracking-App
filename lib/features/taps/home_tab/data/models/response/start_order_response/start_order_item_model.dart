import 'package:freezed_annotation/freezed_annotation.dart';
part 'start_order_item_model.g.dart';

@JsonSerializable()
class StartOrderItemModel {
  @JsonKey(name: 'product')
  final String productId;
  @JsonKey(name: 'price')
  final int price;
  @JsonKey(name: 'quantity')
  final int quantity;
  @JsonKey(name: '_id')
  final String orderItemId;

  StartOrderItemModel({
    required this.productId,
    required this.price,
    required this.quantity,
    required this.orderItemId,
  });

  factory StartOrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$StartOrderItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$StartOrderItemModelToJson(this);
}
