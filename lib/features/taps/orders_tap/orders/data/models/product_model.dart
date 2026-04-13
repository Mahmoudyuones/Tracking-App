import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/product_entity.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'price')
  final num? price;

  ProductModel({this.id, this.price});

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  ProductEntity toEntity() => ProductEntity(id: id, price: price);
}
