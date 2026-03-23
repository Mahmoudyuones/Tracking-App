sealed class ApplySideEffects {}

class ApplyLoading extends ApplySideEffects {}

class ApplyError extends ApplySideEffects {
  final String message;
  ApplyError(this.message);
}

class NavigateToSuccessApply extends ApplySideEffects {}
