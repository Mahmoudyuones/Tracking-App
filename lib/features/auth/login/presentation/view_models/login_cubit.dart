import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../data/models/login_request_model/login_request_model.dart';
import '../../domain/use_cases/login_use_case.dart';
import 'login_intents.dart';
import 'login_states.dart';
import 'login_ui_side_effects.dart';

@injectable
class LoginCubit extends Cubit<LoginStates> {
  LoginCubit(this._useCase) : super(const LoginStates());
  final LoginUseCase _useCase;

  final _effectsController = StreamController<LoginUISideEffects>.broadcast();

  Stream<LoginUISideEffects> get effects => _effectsController.stream;

  Future<void> doIntent(LoginIntents intent) async {
    switch (intent) {
      case SubmitLoginIntent():
        _submitLogin(
          email: intent.email,
          password: intent.password,
          rememberMe: intent.rememberMe,
        );
      case RememberMeIntent():
        emit(state.copyWith(isRememberMe: intent.isRememberMe));
      case NavigateToForgetPasswordIntent():
        _emitEffect(NavigateToForgetPasswordEffect());
    }
  }

  void _emitEffect(LoginUISideEffects effect) {
    if (!_effectsController.isClosed) {
      _effectsController.add(effect);
    }
  }

  Future<void> _submitLogin({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    _emitEffect(LoadingEffect(true));
    emit(state.copyWith(isLoading: true));

    final result = await _useCase.call(
      request: LoginRequestModel(email: email, password: password),
      isRemembered: rememberMe,
    );

    result.when(
      success: (data) async {
        _emitEffect(LoadingEffect(false));
        emit(
          state.copyWith(
            isLoading: false,
            loginState: state.loginState.copyWith(data: data),
          ),
        );
        // if (rememberMe && data.token != null) {
        //   emit(state.copyWith(isRememberMe: true));
        //   await getIt<TokenService>().saveToken(data.token!);
        // }
        _emitEffect(NavigateToHomeEffect());
      },
      failure: (e) {
        _emitEffect(LoadingEffect(false));
        emit(state.copyWith(isLoading: false));
        _emitEffect(ShowErrorEffect(e.getUserMessage()));
      },
    );
  }

  @override
  Future<void> close() {
    _effectsController.close();
    return super.close();
  }
}
