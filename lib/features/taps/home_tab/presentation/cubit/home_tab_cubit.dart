import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../config/base_response/base_response.dart';
import '../../../../../config/base_state/base_state.dart';
import '../../../../../core/constants/app_text_string.dart';
import '../../../../update_order_state/domain/repositories/update_order_state_repository.dart';
import '../../domain/entities/response/pending_orders_response/order_entity.dart';
import '../../domain/repositories/add_order_datails_use_case.dart';
import '../../domain/usecases/get_driver_details_use_case.dart';
import '../../domain/usecases/get_pending_orders_use_case.dart';
import '../../domain/usecases/start_order_use_case.dart';
import '../mappers/order_details_entity_mapper.dart';
import 'home_intents.dart';
import 'home_tab_side_effects.dart';
import 'home_tab_state.dart';

@injectable
class HomeTabCubit extends Cubit<HomeTabState> {
  HomeTabCubit(
    this._getPendingOrdersUseCase,
    this._startOrderUseCase,
    this._addOrderDatailsUseCase,
    this._getDriverDetailsUseCase,
    this._updateOrderStateRepository,
  ) : super(const HomeTabState());

  int _currentPage = 1;
  int _totalPages = 1;
  int _limit = 10;

  final GetPendingOrdersUseCase _getPendingOrdersUseCase;
  final StartOrderUseCase _startOrderUseCase;
  final AddOrderDatailsUseCase _addOrderDatailsUseCase;
  final GetDriverDetailsUseCase _getDriverDetailsUseCase;
  final UpdateOrderStateRepository _updateOrderStateRepository;
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
      case StartOrderIntent():
        _startOrder(intent.orderId, intent.orderDetails);
      case GetMyProfileIntent():
        _getMyProfile();
    }
  }

  Future<void> _getPendingOrders({int? limit}) async {
    _sideEffectsController.add(LoadingSideEffect());
    _limit = limit ?? _limit;
    _currentPage = 1;
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
        final oldOrders = state.getPendingOrdersState!.data!;
        final newOrders = [...oldOrders, ...response.orders];
        emit(
          state.copyWith(
            isLoadingMore: false,
            hasMore: _currentPage < _totalPages,
            getPendingOrdersState: BaseState<List<OrderEntity>>(
              data: newOrders,
            ),
          ),
        );
      },
      failure: (failure) {
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

  Future<void> _startOrder(String orderId, OrderEntity orderDetails) async {
    final driverDetails = state.driverDetails;
    if (driverDetails == null) {
      _sideEffectsController.add(
        ErrorToStartOrderSideEffect(
          message: AppTextString.driverDetailsNotFound,
        ),
      );
      return;
    }
    final orderDetailsEntity = orderDetails.toOrderDetailsEntity(
      driver: driverDetails,
    );
    _sideEffectsController.add(LoadingSideEffect());
    final result = await _startOrderUseCase(orderId);
    final addDetailsResult = await _addOrderDatailsUseCase(
      orderDetails: orderDetailsEntity,
    );
    result.when(
      success: (response) {
        addDetailsResult.when(
          success: (detailsResponse) async {
            final updateStatusResult = await _updateOrderStateRepository
                .updateOrderStatusInFirestore(
                  userId: orderDetails.user.id,
                  orderId: orderId,
                  status: AppTextString.accepted,
                );
            updateStatusResult.when(
              success: (s) {
                _sideEffectsController.add(HideLoadingSideEffect());
                _sideEffectsController.add(
                  SuccessToStartOrderSideEffect(response: response),
                );
              },
              failure: (f) {
                _sideEffectsController.add(HideLoadingSideEffect());
                _sideEffectsController.add(
                  ErrorToStartOrderSideEffect(message: f.message),
                );
              },
            );
          },
          failure: (detailsFailure) {
            _sideEffectsController.add(HideLoadingSideEffect());
            _sideEffectsController.add(
              ErrorToStartOrderSideEffect(message: detailsFailure.message),
            );
          },
        );
      },
      failure: (failure) {
        _sideEffectsController.add(HideLoadingSideEffect());
        _sideEffectsController.add(
          ErrorToStartOrderSideEffect(message: failure.message),
        );
      },
    );
  }

  Future<void> _getMyProfile() async {
    final result = await _getDriverDetailsUseCase();
    result.when(
      success: (response) {
        emit(state.copyWith(driverDetails: response));
      },
      failure: (failure) {},
    );
  }

  @override
  Future<void> close() {
    _sideEffectsController.close();
    return super.close();
  }
}
