import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'firstName')
  final String? firstName;
  @JsonKey(name: 'lastName')
  final String? lastName;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'gender')
  final String? gender;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'photo')
  final String? photo;
  @JsonKey(name: 'passwordChangedAt')
  final DateTime? passwordChangedAt;
  @JsonKey(name: 'passwordResetCode')
  final String? passwordResetCode;
  @JsonKey(name: 'passwordResetExpires')
  final DateTime? passwordResetExpires;
  @JsonKey(name: 'resetCodeVerified')
  final bool? resetCodeVerified;

  const UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.passwordChangedAt,
    this.passwordResetCode,
    this.passwordResetExpires,
    this.resetCodeVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [
    id,
    firstName,
    lastName,
    email,
    gender,
    phone,
    photo,
    passwordChangedAt,
    passwordResetCode,
    passwordResetExpires,
    resetCodeVerified,
  ];
}
