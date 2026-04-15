import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'start_order_model.dart';
part 'start_order_response_model.g.dart';

StartOrderResponseModel startOrderResponseModelFromJson(String str) =>
    StartOrderResponseModel.fromJson(json.decode(str));

String startOrderResponseModelToJson(StartOrderResponseModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class StartOrderResponseModel {
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'orders')
  final StartOrderModel order;

  StartOrderResponseModel({required this.message, required this.order});

  factory StartOrderResponseModel.fromJson(Map<String, dynamic> json) =>
      _$StartOrderResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$StartOrderResponseModelToJson(this);
}
