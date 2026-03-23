import '../../../../config/base_state/base_state.dart';
import '../../domain/entities/orders_response_entity.dart';

class OrdersState {
  final BaseState<OrdersResponseEntity> ordersState;

  OrdersState({required this.ordersState});

  OrdersState copyWith({BaseState<OrdersResponseEntity>? ordersState}) {
    return OrdersState(ordersState: ordersState ?? this.ordersState);
  }
}
