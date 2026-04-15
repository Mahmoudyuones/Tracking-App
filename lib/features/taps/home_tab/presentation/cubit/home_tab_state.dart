import 'package:equatable/equatable.dart';
import '../../../../../config/base_state/base_state.dart';
import '../../domain/entities/response/pending_orders_response/order_entity.dart';

class HomeTabState extends Equatable {
  final BaseState<List<OrderEntity>>? getPendingOrdersState;
  final bool isLoadingMore;
  final bool hasMore;

  const HomeTabState({
    this.getPendingOrdersState,
    this.isLoadingMore = false,
    this.hasMore = false,
  });

  HomeTabState copyWith({
    BaseState<List<OrderEntity>>? getPendingOrdersState,
    bool? isLoadingMore,
    bool? hasMore,
  }) {
    return HomeTabState(
      getPendingOrdersState:
          getPendingOrdersState ?? this.getPendingOrdersState,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object?> get props => [getPendingOrdersState, isLoadingMore, hasMore];
}
