import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/orders_response_entity.dart';
import 'order_wrapper_model.dart';
import 'orders_metadata_model.dart';

part 'orders_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrdersResponseModel {
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'metadata')
  final OrdersMetadataModel? metadata;

  @JsonKey(name: 'orders')
  final List<OrderWrapperModel>? orders;

  OrdersResponseModel({this.message, this.metadata, this.orders});

  factory OrdersResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OrdersResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersResponseModelToJson(this);

  OrdersResponseEntity toEntity() => OrdersResponseEntity(
    message: message,
    metadata: metadata?.toEntity(),
    orders: orders?.map((e) => e.toEntity()).toList(),
  );
}
