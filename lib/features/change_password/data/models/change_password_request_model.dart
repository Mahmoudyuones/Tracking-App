import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'change_password_request_model.g.dart';

@JsonSerializable()
class ChangePasswordRequestModel extends Equatable {
  @JsonKey(name: 'password')
  final String? password;
  @JsonKey(name: 'newPassword')
  final String? newPassword;

  const ChangePasswordRequestModel({this.password, this.newPassword});

  factory ChangePasswordRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordRequestModelToJson(this);

  @override
  List<Object?> get props => [password, newPassword];
}
