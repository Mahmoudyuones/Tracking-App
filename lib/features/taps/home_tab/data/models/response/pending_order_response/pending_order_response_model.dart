import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'meta_data_pending_order_model.dart';
import 'order_model.dart';
part 'pending_order_response_model.g.dart';

PendingOrderResponseModel pendingOrderResponseModelFromJson(String str) =>
    PendingOrderResponseModel.fromJson(json.decode(str));

String pendingOrderResponseModelToJson(PendingOrderResponseModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class PendingOrderResponseModel {
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'metadata')
  final MetadataPendingOrderModel metadata;
  @JsonKey(name: 'orders')
  final List<OrderModel> orders;

  PendingOrderResponseModel({
    required this.message,
    required this.metadata,
    required this.orders,
  });

  factory PendingOrderResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PendingOrderResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PendingOrderResponseModelToJson(this);
}
