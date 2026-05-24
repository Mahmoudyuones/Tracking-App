import 'package:equatable/equatable.dart';
import '../../../../../config/base_state/base_state.dart';
import '../../../../../core/shared/entities/driver_details_entity.dart';
import '../../domain/entities/response/pending_orders_response/order_entity.dart';

class HomeTabState extends Equatable {
  final BaseState<List<OrderEntity>>? getPendingOrdersState;
  final bool isLoadingMore;
  final bool hasMore;
  final DriverDetailEntity? driverDetails;

  const HomeTabState({
    this.getPendingOrdersState,
    this.isLoadingMore = false,
    this.hasMore = false,
    this.driverDetails,
  });

  HomeTabState copyWith({
    BaseState<List<OrderEntity>>? getPendingOrdersState,
    bool? isLoadingMore,
    bool? hasMore,
    DriverDetailEntity? driverDetails,
  }) {
    return HomeTabState(
      getPendingOrdersState:
          getPendingOrdersState ?? this.getPendingOrdersState,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      driverDetails: driverDetails ?? this.driverDetails,
    );
  }

  @override
  List<Object?> get props => [
    getPendingOrdersState,
    isLoadingMore,
    hasMore,
    driverDetails,
  ];
}
