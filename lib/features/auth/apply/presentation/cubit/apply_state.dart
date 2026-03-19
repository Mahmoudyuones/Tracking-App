import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../config/base_state/base_state.dart';

part 'apply_state.freezed.dart';

@freezed
abstract class ApplyState with _$ApplyState {
  const factory ApplyState({
    BaseState? applyState,
    @Default(false) bool fieldsValidation,
    Country? selectedCountry,
    File? vehicleLicense,
    File? nationalIdImg,
  }) = _ApplyState;
}
