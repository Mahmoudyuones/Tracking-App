import 'package:freezed_annotation/freezed_annotation.dart';
part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'slug')
  final String slug;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'imgCover')
  final String imgCover;
  @JsonKey(name: 'images')
  final List<String> images;
  @JsonKey(name: 'price')
  final int price;
  @JsonKey(name: 'priceAfterDiscount')
  final int priceAfterDiscount;
  @JsonKey(name: 'discount')
  final int discount;
  @JsonKey(name: 'rateAvg')
  final int rateAvg;
  @JsonKey(name: 'rateCount')
  final int rateCount;
  @JsonKey(name: 'sold')
  final int sold;
  @JsonKey(name: 'quantity')
  final int quantity;
  @JsonKey(name: 'category')
  final String category;
  @JsonKey(name: 'occasion')
  final String occasion;
  @JsonKey(name: 'isSuperAdmin')
  final bool isSuperAdmin;
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;
  @JsonKey(name: '__v')
  final int v;

  ProductModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.imgCover,
    required this.images,
    required this.price,
    required this.priceAfterDiscount,
    required this.discount,
    required this.rateAvg,
    required this.rateCount,
    required this.sold,
    required this.quantity,
    required this.category,
    required this.occasion,
    required this.isSuperAdmin,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
