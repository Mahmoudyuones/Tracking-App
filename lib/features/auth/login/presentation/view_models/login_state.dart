import 'package:equatable/equatable.dart';

import '../../../../../config/base_state/base_state.dart';
import '../../data/models/login_response_model/login_response_model.dart';

class LoginStates extends Equatable {
  final BaseState<LoginResponseModel> loginState;
  final bool isLoading;
  final bool isRememberMe;

  const LoginStates({
    this.loginState = const BaseState<LoginResponseModel>(),
    this.isLoading = false,
    this.isRememberMe = false,
  });

  LoginStates copyWith({
    BaseState<LoginResponseModel>? loginState,
    bool? isLoading,
    bool? isRememberMe,
  }) {
    return LoginStates(
      loginState: loginState ?? this.loginState,
      isLoading: isLoading ?? this.isLoading,
      isRememberMe: isRememberMe ?? this.isRememberMe,
    );
  }

  @override
  String toString() =>
      'LoginStates(loginState: $loginState, isLoading: $isLoading, isRememberMe: $isRememberMe)';

  @override
  List<Object?> get props => [loginState, isLoading, isRememberMe];
}
