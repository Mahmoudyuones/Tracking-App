import 'package:equatable/equatable.dart';

import '../../../../config/base_state/base_state.dart';
import '../../../../core/shared/entities/order_details_entity.dart';

class UpdateOrderStateState extends Equatable {
  final BaseState<OrderDetailsEntity>? orderDetailsState;
  final bool loadingUpdate;
  final BaseState<void>? changeOrderStatusState;
  final BaseState<void>? updateOrderStatusInFirestoreState;
  final BaseState<void>? updateDriverLocationState;
  final int currentStep;

  const UpdateOrderStateState({
    this.orderDetailsState,
    this.changeOrderStatusState,
    this.updateOrderStatusInFirestoreState,
    this.updateDriverLocationState,
    this.loadingUpdate = false,
    this.currentStep = 0,
  });

  UpdateOrderStateState copyWith({
    BaseState<OrderDetailsEntity>? orderDetailsState,
    BaseState<void>? changeOrderStatusState,
    BaseState<void>? updateOrderStatusInFirestoreState,
    BaseState<void>? updateDriverLocationState,
    bool? loadingUpdate,
    int? currentStep,
  }) {
    return UpdateOrderStateState(
      orderDetailsState: orderDetailsState ?? this.orderDetailsState,
      changeOrderStatusState:
          changeOrderStatusState ?? this.changeOrderStatusState,
      updateOrderStatusInFirestoreState:
          updateOrderStatusInFirestoreState ??
          this.updateOrderStatusInFirestoreState,
      updateDriverLocationState:
          updateDriverLocationState ?? this.updateDriverLocationState,
      loadingUpdate: loadingUpdate ?? this.loadingUpdate,
      currentStep: currentStep ?? this.currentStep,
    );
  }

  @override
  List<Object?> get props => [
    orderDetailsState,
    changeOrderStatusState,
    updateOrderStatusInFirestoreState,
    updateDriverLocationState,
    loadingUpdate,
    currentStep,
  ];
}
