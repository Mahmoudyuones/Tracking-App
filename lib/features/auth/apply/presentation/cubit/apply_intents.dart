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

class SelectVehicleLicenseIntent extends ApplyIntents {
  final File vehicleLicense;
  SelectVehicleLicenseIntent({required this.vehicleLicense});
}

class SelectNationalIdImgIntent extends ApplyIntents {
  final File nationalIdImg;
  SelectNationalIdImgIntent({required this.nationalIdImg});
}
