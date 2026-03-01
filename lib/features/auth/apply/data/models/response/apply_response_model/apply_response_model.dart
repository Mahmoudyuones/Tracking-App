import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import '../../../../../../edit_profile/data/models/response/driver.dart';

part 'apply_response_model.g.dart';

ApplyResponseModel applyResponseModelFromJson(String str) =>
    ApplyResponseModel.fromJson(json.decode(str));

String applyResponseModelToJson(ApplyResponseModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class ApplyResponseModel {
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'driver')
  final Driver driver;
  @JsonKey(name: 'token')
  final String token;

  ApplyResponseModel({
    required this.message,
    required this.driver,
    required this.token,
  });

  factory ApplyResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ApplyResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApplyResponseModelToJson(this);
}
