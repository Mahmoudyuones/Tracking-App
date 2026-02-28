import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/driver_entity.dart';
import '../../domain/entities/driver_response_entity.dart';
import 'driver_model.dart';

part 'driver_response_model.g.dart';

@JsonSerializable()
class DriverResponseModel {
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'driver')
  final DriverModel? driver;

  DriverResponseModel({this.message, this.driver});

  factory DriverResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DriverResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$DriverResponseModelToJson(this);

  DriverResponseEntity toEntity() {
    return DriverResponseEntity(
      driver:
          driver?.toEntity() ??
          const DriverEntity(
            firstName: '',
            lastName: '',
            vehicleType: '',
            vehicleNumber: '',
            email: '',
            phone: '',
            photo: '',
          ),
    );
  }
}
