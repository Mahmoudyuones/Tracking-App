import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_item_firebase_model.g.dart';

@JsonSerializable()
class OrderItemFirebaseModel {
  final String itemId;
  final String productId;
  final String title;
  final String slug;
  final String description;
  final String imgCover;
  final num priceAfterDiscount;
  final num price;
  final int quantity;

  OrderItemFirebaseModel({
    required this.itemId,
    required this.productId,
    required this.title,
    required this.slug,
    required this.description,
    required this.imgCover,
    required this.priceAfterDiscount,
    required this.price,
    required this.quantity,
  });

  factory OrderItemFirebaseModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFirebaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemFirebaseModelToJson(this);
}
