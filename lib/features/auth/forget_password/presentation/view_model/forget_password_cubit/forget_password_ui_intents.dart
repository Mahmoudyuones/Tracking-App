sealed class ForgetPasswordUiIntents {}

// --- Provide Email UI Intents ---

class ShowLoadingProvideEmailIntent extends ForgetPasswordUiIntents {}

class ShowErrorProvideEmailIntent extends ForgetPasswordUiIntents {
  final String errorMessage;
  ShowErrorProvideEmailIntent(this.errorMessage);
}

class NavigateToVerifyIntent extends ForgetPasswordUiIntents {}

// --- Verify Code UI Intents ---

class ShowLoadingVerifyIntent extends ForgetPasswordUiIntents {}

class ShowErrorMsgVerifyIntent extends ForgetPasswordUiIntents {
  final String errorMessage;
  ShowErrorMsgVerifyIntent(this.errorMessage);
}

class ShowSuccessMsgVerifyIntent extends ForgetPasswordUiIntents {
  final String message;
  ShowSuccessMsgVerifyIntent(this.message);
}

class NavigateToResetPasswordIntent extends ForgetPasswordUiIntents {}

// --- Reset Password UI Intents ---

class ShowLoadingResetPasswordIntent extends ForgetPasswordUiIntents {}

class ShowErrorMsgResetPasswordIntent extends ForgetPasswordUiIntents {
  final String errorMessage;
  ShowErrorMsgResetPasswordIntent(this.errorMessage);
}

class NavigateToLoginIntent extends ForgetPasswordUiIntents {
  final String message;

  NavigateToLoginIntent(this.message);
}
