import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../../../core/constants/app_text_string.dart';
import '../../../../core/validators/app_validators.dart';

import '../../data/models/request/edit_profile_request.dart';
import '../../domain/use_cases/edit_profile_use_case.dart';
import '../../domain/use_cases/update_profile_image_use_case.dart';
import 'edit_profile_intents.dart';
import 'edit_profile_states.dart';
import 'edit_profile_ui_intents.dart';

@injectable
class EditProfileCubit extends Cubit<EditProfileStates> {
  EditProfileCubit({
    required this.editProfileUseCase,
    required this.updateProfileImageUseCase,
  }) : super(const EditProfileStates());

  final EditProfileUseCase editProfileUseCase;
  final UpdateProfileImageUseCase updateProfileImageUseCase;

  final StreamController<EditProfileUiIntents> _uiIntentsController =
      StreamController<EditProfileUiIntents>.broadcast();

  Stream<EditProfileUiIntents> get uiIntentsStream =>
      _uiIntentsController.stream;

  void loadFromDriver({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String photoUrl,
  }) {
    final next = state.copyWith(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      photoUrl: photoUrl,
    );
    emit(next.copyWith(isValidForm: _isFormValid(next)));
  }

  void doIntent(EditProfileIntents intent) {
    switch (intent) {
      case UpdateProfilePhotoIntent():
        _uploadProfilePhoto(intent.photo);

      case FirstNameChangedIntent():
        _onFirstNameChanged(intent.firstName);

      case LastNameChangedIntent():
        _onLastNameChanged(intent.lastName);

      case EmailChangedIntent():
        _onEmailChanged(intent.email);

      case PhoneChangedIntent():
        _onPhoneChanged(intent.phone);

      case UpdateProfileSubmitIntent():
        _updateProfile();
    }
  }

  @override
  Future<void> close() {
    _uiIntentsController.close();
    return super.close();
  }

  void _onFirstNameChanged(String firstName) {
    final next = state.copyWith(firstName: firstName);
    emit(next.copyWith(isValidForm: _isFormValid(next)));
  }

  void _onLastNameChanged(String lastName) {
    final next = state.copyWith(lastName: lastName);
    emit(next.copyWith(isValidForm: _isFormValid(next)));
  }

  void _onEmailChanged(String email) {
    final next = state.copyWith(email: email);
    emit(next.copyWith(isValidForm: _isFormValid(next)));
  }

  void _onPhoneChanged(String phone) {
    final next = state.copyWith(phone: phone);
    emit(next.copyWith(isValidForm: _isFormValid(next)));
  }

  bool _isFormValid(EditProfileStates state) {
    return state.firstName.validateRequired == null &&
        state.lastName.validateRequired == null &&
        state.email.validateEmail == null &&
        AppValidators.validatePhoneNumber(state.phone) == null;
  }

  Future<void> _updateProfile() async {
    _uiIntentsController.add(ShowLoadingIntent());

    final request = EditProfileRequest(
      firstName: state.firstName,
      lastName: state.lastName,
      email: state.email,
      phone: state.phone,
    );

    final result = await editProfileUseCase(request);
    result.when(
      success: (_) {
        _uiIntentsController.add(
          UpdateProfileSuccessIntent(AppTextString.profileUpdatedSuccessfully),
        );
      },
      failure: (error) {
        _uiIntentsController.add(ShowErrorIntent(error.getUserMessage()));
      },
    );
  }

  Future<void> _uploadProfilePhoto(File image) async {
    _uiIntentsController.add(ShowPhotoLoadingIntent());

    final result = await updateProfileImageUseCase(image);
    result.when(
      success: (_) {
        _uiIntentsController.add(const UpdatePhotoSuccessIntent());
      },
      failure: (error) {
        _uiIntentsController.add(ShowErrorIntent(error.getUserMessage()));
      },
    );
  }
}
