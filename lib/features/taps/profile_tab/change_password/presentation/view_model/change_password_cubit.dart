import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../config/base_response/base_response.dart';
import '../../../../../../core/validators/app_validators.dart';
import '../../domain/entities/change_password_request_entity.dart';
import '../../domain/use_cases/change_password_use_case.dart';
import 'change_password_intents.dart';
import 'change_password_states.dart';
import 'change_pasword_ui_events.dart';

@injectable
class ChangePasswordCubit extends Cubit<ChangePasswordStates> {
  final ChangePasswordUseCase _changePasswordUseCase;
  final _uiEventController =
      StreamController<ChangePaswordUiEvents>.broadcast();

  Stream<ChangePaswordUiEvents> get uiEvents => _uiEventController.stream;

  ChangePasswordCubit(this._changePasswordUseCase)
    : super(const ChangePasswordStates());

  Future<void> doIntent(ChangePasswordIntents intent) async {
    switch (intent) {
      case UpdatePasswordSubmitIntent(
        changePasswordRequestEntity: final requestEntity,
      ):
        await _updatePassword(requestEntity);
      case ValidateFields(
        password: final password,
        newPassword: final newPassword,
        confirmPassword: final confirmPassword,
      ):
        _validateForm(password, newPassword, confirmPassword);
    }
  }

  Future<void> _updatePassword(
    ChangePasswordRequestEntity requestEntity,
  ) async {
    _uiEventController.add(ChangePasswordLoadingEvent());
    final response = await _changePasswordUseCase(requestEntity);
    response.when(
      success: (data) {
        _uiEventController.add(ChangePasswordSuccessEvent());
      },
      failure: (error) {
        _uiEventController.add(
          ChangePasswordFailureEvent(message: error.getUserMessage()),
        );
      },
    );
  }

  void _validateForm(
    String password,
    String newPassword,
    String confirmPassword,
  ) {
    final isValid =
        password.validatePassword == null &&
        newPassword.validatePassword == null &&
        password != newPassword &&
        confirmPassword.validateMatch(newPassword) == null;
    emit(state.copyWith(isValidForm: isValid));
  }
}
