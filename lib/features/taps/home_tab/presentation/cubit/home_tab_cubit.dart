import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../../../../config/base_state/base_state.dart';
import '../../domain/entities/response/pending_orders_response/order_entity.dart';
import '../../domain/usecases/get_pending_orders_use_case.dart';
import 'home_intents.dart';
import 'home_tab_side_effects.dart';
import 'home_tab_state.dart';

@injectable
class HomeTabCubit extends Cubit<HomeTabState> {
  HomeTabCubit(this._getPendingOrdersUseCase) : super(const HomeTabState());

  final GetPendingOrdersUseCase _getPendingOrdersUseCase;
  final StreamController<HomeTabSideEffects> _sideEffectsController =
      StreamController<HomeTabSideEffects>.broadcast();

  Stream<HomeTabSideEffects> get sideEffects => _sideEffectsController.stream;

  void doIntent(HomeIntents intent) {
    switch (intent) {
      case GetPendingOrdersIntent():
        _getPendingOrders(intent.limit);
    }
  }

  Future<void> _getPendingOrders(int limit) async {
    _sideEffectsController.add(LoadingPendingOrdersSideEffect());
    final result = await _getPendingOrdersUseCase(limit: limit);
    result.when(
      success: (response) {
        _sideEffectsController.add(HideLoadingSideEffect());
        emit(
          state.copyWith(
            getPendingOrdersState: BaseState<List<OrderEntity>>(
              data: response.orders,
            ),
          ),
        );
      },
      failure: (failure) {
        _sideEffectsController.add(HideLoadingSideEffect());
        emit(
          state.copyWith(
            getPendingOrdersState: BaseState<List<OrderEntity>>(
              errorMessage: failure.message,
            ),
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _sideEffectsController.close();
    return super.close();
  }
}
