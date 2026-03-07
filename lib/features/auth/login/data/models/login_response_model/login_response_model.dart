import 'package:json_annotation/json_annotation.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel {
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'token')
  final String? token;

  const LoginResponseModel({this.message, this.token});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);

  @override
  String toString() =>
      'LoginResponseModel(message: $message, token: ${token != null ? '***redacted***' : 'null'}';
}
