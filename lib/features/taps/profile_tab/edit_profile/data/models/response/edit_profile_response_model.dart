import 'package:freezed_annotation/freezed_annotation.dart';
import 'driver.dart';

part 'edit_profile_response_model.g.dart';

@JsonSerializable()
class EditProfileResponseModel {
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'driver')
  final Driver driver;

  EditProfileResponseModel({required this.message, required this.driver});

  factory EditProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$EditProfileResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileResponseModelToJson(this);
}
