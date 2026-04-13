import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
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

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.passwordChangedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserEntity toEntity() => UserEntity(
    id: id,
    firstName: firstName,
    lastName: lastName,
    email: email,
    gender: gender,
    phone: phone,
    photo: photo,
    passwordChangedAt: passwordChangedAt,
  );
}
