import '../../domain/entities/orders_response_entity.dart';

sealed class OrdersUiEvent {}

class LoadingUiEvent extends OrdersUiEvent {}

class ErrorUiEvent extends OrdersUiEvent {
  final String message;
  ErrorUiEvent({required this.message});
}

class SuccessUiEvent extends OrdersUiEvent {
  final OrdersResponseEntity ordersResponseEntity;
  SuccessUiEvent({required this.ordersResponseEntity});
}
