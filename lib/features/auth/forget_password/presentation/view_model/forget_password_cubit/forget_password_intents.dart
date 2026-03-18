sealed class ForgetPasswordIntents {}

// --- Provide Email Intents ---

class EmailChangedIntent extends ForgetPasswordIntents {
  final String email;
  EmailChangedIntent(this.email);
}

class ConfirmEmailIntent extends ForgetPasswordIntents {}

// --- Verify Code Intents ---

class OtpChangedIntent extends ForgetPasswordIntents {
  final String code;

  OtpChangedIntent(this.code);
}

class ResendCodeIntent extends ForgetPasswordIntents {
  final String email;

  ResendCodeIntent(this.email);
}

class SubmitCodeIntent extends ForgetPasswordIntents {
  SubmitCodeIntent();
}

// --- Reset Password Intents ---

class NewPasswordChangedIntent extends ForgetPasswordIntents {
  final String newPassword;

  NewPasswordChangedIntent(this.newPassword);
}

class ConfirmPasswordChangedIntent extends ForgetPasswordIntents {
  final String confirmPassword;

  ConfirmPasswordChangedIntent(this.confirmPassword);
}

class ConfirmResetPasswordIntent extends ForgetPasswordIntents {}
