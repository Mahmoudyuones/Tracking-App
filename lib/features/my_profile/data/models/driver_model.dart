import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/driver_entity.dart';

part 'driver_model.g.dart';

@JsonSerializable()
class DriverModel {
  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'country')
  final String? country;

  @JsonKey(name: 'firstName')
  final String? firstName;

  @JsonKey(name: 'lastName')
  final String? lastName;

  @JsonKey(name: 'vehicleType')
  final String? vehicleType;

  @JsonKey(name: 'vehicleNumber')
  final String? vehicleNumber;

  @JsonKey(name: 'vehicleLicense')
  final String? vehicleLicense;

  @JsonKey(name: 'NID')
  final String? nid;

  @JsonKey(name: 'NIDImg')
  final String? nidImg;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'gender')
  final String? gender;

  @JsonKey(name: 'phone')
  final String? phone;

  @JsonKey(name: 'photo')
  final String? photo;

  @JsonKey(name: 'role')
  final String? role;

  @JsonKey(name: 'createdAt')
  final String? createdAt;

  DriverModel({
    this.id,
    this.country,
    this.firstName,
    this.lastName,
    this.vehicleType,
    this.vehicleNumber,
    this.vehicleLicense,
    this.nid,
    this.nidImg,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.role,
    this.createdAt,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) =>
      _$DriverModelFromJson(json);

  Map<String, dynamic> toJson() => _$DriverModelToJson(this);

  DriverEntity toEntity() {
    return DriverEntity(
      firstName: firstName ?? '',
      lastName: lastName ?? '',
      vehicleType: vehicleType ?? '',
      vehicleNumber: vehicleNumber ?? '',
      email: email ?? '',
      phone: phone ?? '',
      photo: photo ?? '',
    );
  }
}
