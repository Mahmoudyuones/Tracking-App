import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/order_wrapper_entity.dart';
import 'order_model.dart';
import 'store_model.dart';

part 'order_wrapper_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderWrapperModel {
  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'driver')
  final String? driver;

  @JsonKey(name: 'order')
  final OrderModel? order;

  @JsonKey(name: '__v')
  final int? v;

  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;

  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;

  @JsonKey(name: 'store')
  final StoreModel? store;

  OrderWrapperModel({
    this.id,
    this.driver,
    this.order,
    this.v,
    this.createdAt,
    this.updatedAt,
    this.store,
  });

  factory OrderWrapperModel.fromJson(Map<String, dynamic> json) =>
      _$OrderWrapperModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderWrapperModelToJson(this);

  OrderWrapperEntity toEntity() => OrderWrapperEntity(
    id: id,
    driver: driver,
    order: order?.toEntity(),
    v: v,
    createdAt: createdAt,
    updatedAt: updatedAt,
    store: store?.toEntity(),
  );
}
