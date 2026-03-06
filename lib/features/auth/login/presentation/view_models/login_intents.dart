sealed class LoginIntents {}

class SubmitLoginIntent extends LoginIntents {
  final String email;
  final String password;
  final bool rememberMe;

  SubmitLoginIntent({
    required this.email,
    required this.password,
    this.rememberMe = false,
  });
}

class RememberMeIntent extends LoginIntents {
  final bool isRememberMe;

  RememberMeIntent({this.isRememberMe = false});
}

class NavigateToForgetPasswordIntent extends LoginIntents {}
