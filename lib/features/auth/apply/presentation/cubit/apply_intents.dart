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
  final bool formsValid;
  ValidateFieldsIntent({required this.formsValid});
}
