sealed class ChangePaswordUiEvents {}

class ChangePasswordLoadingEvent extends ChangePaswordUiEvents {}

class ChangePasswordFailureEvent extends ChangePaswordUiEvents {
  final String message;

  ChangePasswordFailureEvent({required this.message});
}

class ChangePasswordSuccessEvent extends ChangePaswordUiEvents {}
