sealed class LoginIntent {}

class SubmitLoginIntent extends LoginIntent {
  final String email;
  final String password;
  final bool rememberMe;

  SubmitLoginIntent({
    required this.email,
    required this.password,
    this.rememberMe = false,
  });
}

class RememberMeIntent extends LoginIntent {
  final bool isRememberMe;

  RememberMeIntent({this.isRememberMe = false});
}

class NavigateToForgetPasswordIntent extends LoginIntent {}

//-------------------- UI EFFECTS (SIDE EFFECTS) --------------------//
sealed class LoginEffect {}

class NavigateToHomeEffect extends LoginEffect {}

class NavigateToForgetPasswordEffect extends LoginEffect {}

class ShowErrorEffect extends LoginEffect {
  final String message;
  ShowErrorEffect(this.message);
}

class LoadingEffect extends LoginEffect {
  final bool isLoading;
  LoadingEffect(this.isLoading);
}
