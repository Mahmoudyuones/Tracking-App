import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_order_state_request_model.g.dart';

@JsonSerializable()
class UpdateOrderStateRequestModel {
  final String state;

  UpdateOrderStateRequestModel({required this.state});

  factory UpdateOrderStateRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateOrderStateRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateOrderStateRequestModelToJson(this);
}
