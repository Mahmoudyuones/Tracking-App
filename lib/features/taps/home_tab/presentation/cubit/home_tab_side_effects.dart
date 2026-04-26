import '../../domain/entities/response/start_order_response/start_order_response_entity.dart';

sealed class HomeTabSideEffects {}

class LoadingSideEffect extends HomeTabSideEffects {}

class HideLoadingSideEffect extends HomeTabSideEffects {}

class ErrorToStartOrderSideEffect extends HomeTabSideEffects {
  final String message;
  ErrorToStartOrderSideEffect({required this.message});
}

class SuccessToStartOrderSideEffect extends HomeTabSideEffects {
  final StartOrderResponseEntity response;
  SuccessToStartOrderSideEffect({required this.response});
}
