import 'dart:io';

import 'package:country_picker/country_picker.dart';

import '../../domain/entities/request/apply_request_entity.dart';

sealed class ApplyIntents {}

class SubmitApplyIntent extends ApplyIntents {
  final ApplyRequestEntity request;
  SubmitApplyIntent({required this.request});
}

class SelectCountryIntent extends ApplyIntents {
  final Country country;
  SelectCountryIntent({required this.country});
}

class SelectVehicleTypeIntent extends ApplyIntents {
  final String vehicleType;
  SelectVehicleTypeIntent({required this.vehicleType});
}

class SelectVehicleLicenseIntent extends ApplyIntents {
  final File vehicleLicense;
  SelectVehicleLicenseIntent({required this.vehicleLicense});
}

class SelectNationalIdImgIntent extends ApplyIntents {
  final File nationalIdImg;
  SelectNationalIdImgIntent({required this.nationalIdImg});
}

class TogglePasswordVisibilityIntent extends ApplyIntents {
  final bool isPasswordVisible;
  TogglePasswordVisibilityIntent({required this.isPasswordVisible});
}

class ToggleConfirmPasswordVisibilityIntent extends ApplyIntents {
  final bool isConfirmPasswordVisible;
  ToggleConfirmPasswordVisibilityIntent({
    required this.isConfirmPasswordVisible,
  });
}

class SelectGenderIntent extends ApplyIntents {
  final String gender;
  SelectGenderIntent({required this.gender});
}

class ValidateFieldsIntent extends ApplyIntents {
  final String? firstName;
  final String? secondName;
  final String? vehicleType;
  final String? vehicleNumber;
  final File? vehicleLicense;
  final String? nationalId;
  final File? nationalIdImg;
  final String? email;
  final String? password;
  final String? confirmPassword;
  final String? gender;
  final String? phone;
  ValidateFieldsIntent({
    this.firstName,
    this.secondName,
    this.vehicleType,
    this.vehicleNumber,
    this.vehicleLicense,
    this.nationalId,
    this.nationalIdImg,
    this.email,
    this.password,
    this.confirmPassword,
    this.gender,
    this.phone,
  });
}
