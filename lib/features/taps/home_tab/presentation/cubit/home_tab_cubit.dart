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

  int _currentPage = 1;
  int _totalPages = 1;
  int _limit = 10;

  final GetPendingOrdersUseCase _getPendingOrdersUseCase;
  final StreamController<HomeTabSideEffects> _sideEffectsController =
      StreamController<HomeTabSideEffects>.broadcast();

  Stream<HomeTabSideEffects> get sideEffects => _sideEffectsController.stream;

  void doIntent(HomeIntents intent) {
    switch (intent) {
      case GetPendingOrdersIntent():
        _getPendingOrders(limit: intent.limit);
      case LoadMorePendingOrdersIntent():
        _loadMorePendingOrders();
      case RejectOrderIntent():
        _rejectOrder(intent.orderId);
      case AcceptOrderIntent():
      // _acceptOrder(intent.orderId);
    }
  }

  Future<void> _getPendingOrders({int? limit}) async {
    _sideEffectsController.add(LoadingPendingOrdersSideEffect());
    _limit = limit ?? _limit;
    final result = await _getPendingOrdersUseCase(limit: _limit, page: 1);
    result.when(
      success: (response) {
        _totalPages = response.metadata.totalPages;
        _sideEffectsController.add(HideLoadingSideEffect());
        emit(
          state.copyWith(
            getPendingOrdersState: BaseState<List<OrderEntity>>(
              data: response.orders,
            ),
            hasMore: _currentPage < _totalPages,
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

  Future<void> _loadMorePendingOrders() async {
    if (!state.hasMore || state.isLoadingMore) return;
    emit(state.copyWith(isLoadingMore: true));

    _currentPage++;

    final result = await _getPendingOrdersUseCase(
      limit: _limit,
      page: _currentPage,
    );
    result.when(
      success: (response) {
        emit(
          state.copyWith(
            isLoadingMore: false,
            hasMore: _currentPage < _totalPages,
            getPendingOrdersState: BaseState<List<OrderEntity>>(
              data: [...state.getPendingOrdersState!.data!, ...response.orders],
            ),
          ),
        );
      },
      failure: (failure) {
        _sideEffectsController.add(HideLoadingSideEffect());
        emit(
          state.copyWith(
            isLoadingMore: false,
            hasMore: _currentPage < _totalPages,
            getPendingOrdersState: BaseState<List<OrderEntity>>(
              errorMessage: failure.message,
            ),
          ),
        );
      },
    );
  }

  Future<void> _rejectOrder(String orderId) async {
    final newOrders = state.getPendingOrdersState!.data!
        .where((order) => order.id != orderId)
        .toList();
    emit(
      state.copyWith(
        getPendingOrdersState: BaseState<List<OrderEntity>>(data: newOrders),
      ),
    );
  }

  @override
  Future<void> close() {
    _sideEffectsController.close();
    return super.close();
  }
}
