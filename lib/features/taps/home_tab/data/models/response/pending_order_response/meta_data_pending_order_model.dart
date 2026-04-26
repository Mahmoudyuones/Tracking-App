import 'package:freezed_annotation/freezed_annotation.dart';
part 'meta_data_pending_order_model.g.dart';

@JsonSerializable()
class MetadataPendingOrderModel {
  @JsonKey(name: 'currentPage')
  final int currentPage;
  @JsonKey(name: 'totalPages')
  final int totalPages;
  @JsonKey(name: 'totalItems')
  final int totalItems;
  @JsonKey(name: 'limit')
  final int limit;

  MetadataPendingOrderModel({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.limit,
  });

  factory MetadataPendingOrderModel.fromJson(Map<String, dynamic> json) =>
      _$MetadataPendingOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataPendingOrderModelToJson(this);
}
