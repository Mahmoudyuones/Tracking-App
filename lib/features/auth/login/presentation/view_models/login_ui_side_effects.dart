//-------------------- UI EFFECTS (SIDE EFFECTS) --------------------//
sealed class LoginUISideEffects {}

class NavigateToHomeEffect extends LoginUISideEffects {}

class NavigateToForgetPasswordEffect extends LoginUISideEffects {}

class ShowErrorEffect extends LoginUISideEffects {
  final String message;

  ShowErrorEffect(this.message);
}

class LoadingEffect extends LoginUISideEffects {
  final bool isLoading;

  LoadingEffect(this.isLoading);
}
