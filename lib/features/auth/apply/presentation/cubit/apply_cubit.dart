import 'dart:async';
import 'dart:io';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../config/base_response/base_response.dart';
import '../../../../../config/base_state/base_state.dart';
import '../../domain/entities/request/apply_request_entity.dart';
import '../../domain/usecases/apply_use_case.dart';
import 'apply_intents.dart';
import 'apply_side_effects.dart';
import 'apply_state.dart';

@injectable
class ApplyCubit extends Cubit<ApplyState> {
  final ApplyUseCase applyUseCase;
  ApplyCubit(this.applyUseCase) : super(const ApplyState());

  final StreamController<ApplySideEffects> _sideEffectsController =
      StreamController<ApplySideEffects>.broadcast();

  Stream<ApplySideEffects> get sideEffects => _sideEffectsController.stream;

  void doIntent(ApplyIntents intent) {
    switch (intent) {
      case SubmitApplyIntent(request: final request):
        _doApply(request);
      case SelectCountryIntent(country: final country):
        _selectCountry(country);
      case SelectVehicleLicenseIntent(vehicleLicense: final vehicleLicense):
        _selectVehicleLicense(vehicleLicense);
      case SelectNationalIdImgIntent(nationalIdImg: final nationalIdImg):
        _selectNationalIdImg(nationalIdImg);
      case TogglePasswordVisibilityIntent(
        isPasswordVisible: final isPasswordVisible,
      ):
        _togglePasswordVisibility(isPasswordVisible);
      case ToggleConfirmPasswordVisibilityIntent(
        isConfirmPasswordVisible: final isConfirmPasswordVisible,
      ):
        _toggleConfirmPasswordVisibility(isConfirmPasswordVisible);
      case SelectGenderIntent(gender: final gender):
        _selectGender(gender);
      case ValidateFieldsIntent(formsValid: final formsValid):
        _validateFields(formsValid: formsValid);
      case SelectVehicleTypeIntent(vehicleType: final vehicleType):
        _selectVehicleType(vehicleType);
    }
  }

  void _selectCountry(Country country) {
    emit(state.copyWith(selectedCountry: country));
  }

  void _selectVehicleType(String vehicleType) {
    emit(state.copyWith(vehicleType: vehicleType));
  }

  void _selectGender(String gender) {
    emit(state.copyWith(gender: gender));
  }

  void _selectVehicleLicense(File vehicleLicense) {
    emit(state.copyWith(vehicleLicense: vehicleLicense));
  }

  void _selectNationalIdImg(File nationalIdImg) {
    emit(state.copyWith(nationalIdImg: nationalIdImg));
  }

  void _togglePasswordVisibility(bool isPasswordVisible) {
    emit(state.copyWith(isPasswordVisible: isPasswordVisible));
  }

  void _toggleConfirmPasswordVisibility(bool isConfirmPasswordVisible) {
    emit(state.copyWith(isConfirmPasswordVisible: isConfirmPasswordVisible));
  }

  void _doApply(ApplyRequestEntity request) async {
    _sideEffectsController.add(ApplyLoading());
    final response = await applyUseCase(request);
    response.when(
      success: (successMessage) {
        emit(state.copyWith(applyState: BaseState(data: successMessage)));
        _sideEffectsController.add(NavigateToSuccessApply());
      },
      failure: (failure) {
        _sideEffectsController.add(ApplyError(failure.message));
      },
    );
  }

  void _validateFields({required bool formsValid}) {
    emit(state.copyWith(fieldsValidation: formsValid));
  }

  @override
  Future<void> close() {
    _sideEffectsController.close();
    return super.close();
  }
}
