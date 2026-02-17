import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../../../../config/di/di.dart';
import '../../../../../config/services/session_manager_service.dart';
import '../../../../../config/services/token_service.dart';
import '../../data/models/login_request_model/login_request_model.dart';
import '../../domain/use_cases/login_use_case.dart';
import 'login_events.dart';
import 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginStates> {
  LoginCubit(this._useCase) : super(const LoginStates());
  final LoginUseCase _useCase;

  final _effectsController = StreamController<LoginEffect>.broadcast();

  Stream<LoginEffect> get effects => _effectsController.stream;

  Future<void> doIntent(LoginIntent intent) async {
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

  void _emitEffect(LoginEffect effect) {
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
        if (rememberMe) {
          state.copyWith(isRememberMe: true);
          await getIt<TokenService>().saveToken(data.token!);
        }
        getIt<SessionManagerService>().notifySessionExpired();
        await Future.delayed(Duration.zero);
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
