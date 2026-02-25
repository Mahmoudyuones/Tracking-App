import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info_model.g.dart';

@JsonSerializable()
class UserInfoModel {
  final String userId;
  final String firstName;
  final String lastName;
  final String phone;
  final String photo;

  UserInfoModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.photo,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoModelToJson(this);
}
