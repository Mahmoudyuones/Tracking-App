import 'package:json_annotation/json_annotation.dart';

part 'product_order_model.g.dart';

@JsonSerializable()
class ProductOrderModel {
  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'slug')
  final String? slug;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'imgCover')
  final String? imgCover;

  @JsonKey(name: 'images')
  final List<String>? images;

  @JsonKey(name: 'price')
  final num? price;

  @JsonKey(name: 'priceAfterDiscount')
  final num? priceAfterDiscount;

  @JsonKey(name: 'quantity')
  final int? quantity;

  @JsonKey(name: 'category')
  final String? category;

  @JsonKey(name: 'occasion')
  final String? occasion;

  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;

  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;

  @JsonKey(name: '__v')
  final int? v;

  @JsonKey(name: 'isSuperAdmin')
  final bool? isSuperAdmin;

  @JsonKey(name: 'sold')
  final int? sold;

  @JsonKey(name: 'rateAvg')
  final num? rateAvg;

  @JsonKey(name: 'rateCount')
  final int? rateCount;

  @JsonKey(name: 'favoriteId')
  final dynamic favoriteId;

  @JsonKey(name: 'isInWishlist')
  final bool? isInWishlist;

  ProductOrderModel({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.quantity,
    this.category,
    this.occasion,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isSuperAdmin,
    this.sold,
    this.rateAvg,
    this.rateCount,
    this.favoriteId,
    this.isInWishlist,
  });

  factory ProductOrderModel.fromJson(Map<String, dynamic> json) =>
      _$ProductOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductOrderModelToJson(this);
}
