import 'package:equatable/equatable.dart';
import '../../../../../config/base_state/base_state.dart';
import '../../domain/entities/response/pending_orders_response/order_entity.dart';

class HomeTabState extends Equatable{

  final BaseState<List<OrderEntity>>? getPendingOrdersState;

  const HomeTabState({this.getPendingOrdersState});

  HomeTabState copyWith({
    BaseState<List<OrderEntity>>? getPendingOrdersState,
  }) {
    return HomeTabState(
      getPendingOrdersState: getPendingOrdersState ?? this.getPendingOrdersState,
    );
  }

  @override
  List<Object?> get props => [getPendingOrdersState];
}