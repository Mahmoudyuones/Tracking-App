import 'package:json_annotation/json_annotation.dart';
import 'product_order_model.dart';

part 'product_details_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductDetailsResponseModel {
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'product')
  final ProductOrderModel? product;

  ProductDetailsResponseModel({this.message, this.product});

  factory ProductDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailsResponseModelToJson(this);
}
