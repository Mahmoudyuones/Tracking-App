import 'dart:io';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../../../../core/constants/json_serlization_constants.dart';

part 'edit_vehicle_request.g.dart';

@JsonSerializable()
class EditVehicleRequest {
  @JsonKey(name: JsonSerlizationConstants.vehicleType)
  final String? vehicleType;

  @JsonKey(name: JsonSerlizationConstants.vehicleNumber)
  final String? vehicleNumber;

  @JsonKey(name:JsonSerlizationConstants.vehicleLicense,includeFromJson: false, includeToJson: false)
  final File? vehicleLicenseFile;

  EditVehicleRequest({
    this.vehicleType,
    this.vehicleNumber,
    this.vehicleLicenseFile,
  });

  factory EditVehicleRequest.fromJson(Map<String, dynamic> json) {
    return _$EditVehicleRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EditVehicleRequestToJson(this);
  }

  Future<Map<String, dynamic>> toFormDataMap() async {
    final map = <String, dynamic>{};
    if (vehicleType != null) {
      map[JsonSerlizationConstants.vehicleType] = vehicleType;
    }

    if (vehicleNumber != null) {
      map[JsonSerlizationConstants.vehicleNumber] = vehicleNumber;
    }

    if (vehicleLicenseFile != null) {
      String fileName = vehicleLicenseFile!.path.split('/').last;

      map[JsonSerlizationConstants.vehicleLicense] = await MultipartFile.fromFile(
        vehicleLicenseFile!.path,
        filename: fileName,
      );
    }

    return map;
  }
}