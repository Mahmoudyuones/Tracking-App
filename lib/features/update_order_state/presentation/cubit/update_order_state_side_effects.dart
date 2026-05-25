sealed class UpdateOrderStateSideEffects {
  const UpdateOrderStateSideEffects();
}

class Loading extends UpdateOrderStateSideEffects {
  const Loading();
}

class HideLoading extends UpdateOrderStateSideEffects {
  const HideLoading();
}

class UpdateOrderStatusSuccessSideEffect extends UpdateOrderStateSideEffects {
  const UpdateOrderStatusSuccessSideEffect();
}
