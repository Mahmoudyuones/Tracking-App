import 'package:freezed_annotation/freezed_annotation.dart';
import 'order_data_model.dart';

part 'update_order_state_response_model.g.dart';

@JsonSerializable()
class UpdateOrderStateResponseModel {
  final String? message;
  final OrderDataModel? orders;

  UpdateOrderStateResponseModel({this.message, this.orders});

  factory UpdateOrderStateResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateOrderStateResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateOrderStateResponseModelToJson(this);
}
