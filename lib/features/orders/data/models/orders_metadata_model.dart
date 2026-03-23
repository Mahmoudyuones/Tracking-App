import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/orders_metadata_entity.dart';

part 'orders_metadata_model.g.dart';

@JsonSerializable()
class OrdersMetadataModel {
  @JsonKey(name: 'currentPage')
  final int? currentPage;

  @JsonKey(name: 'totalPages')
  final int? totalPages;

  @JsonKey(name: 'totalItems')
  final int? totalItems;

  @JsonKey(name: 'limit')
  final int? limit;

  OrdersMetadataModel({
    this.currentPage,
    this.totalPages,
    this.totalItems,
    this.limit,
  });

  factory OrdersMetadataModel.fromJson(Map<String, dynamic> json) =>
      _$OrdersMetadataModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersMetadataModelToJson(this);

  OrdersMetadataEntity toEntity() => OrdersMetadataEntity(
    currentPage: currentPage,
    totalPages: totalPages,
    totalItems: totalItems,
    limit: limit,
  );
}
