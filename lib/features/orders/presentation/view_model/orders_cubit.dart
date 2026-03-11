import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../../../config/base_state/base_state.dart';
import '../../domain/entities/orders_response_entity.dart';
import '../../domain/usecases/get_orders_usecase.dart';
import 'orders_events.dart';
import 'orders_state.dart';
import 'orders_ui_events.dart';

@injectable
class OrdersCubit extends Cubit<OrdersState> {
  final GetOrdersUsecase _getOrdersUsecase;

  OrdersCubit(this._getOrdersUsecase)
    : super(OrdersState(ordersState: const BaseState<OrdersResponseEntity>()));

  final _uiEventController = StreamController<OrdersUiEvent>.broadcast();
  Stream<OrdersUiEvent> get uiEventStream => _uiEventController.stream;

  void onEvent(OrdersEvent event) {
    switch (event) {
      case GetOrdersEvent():
        _getOrders();
    }
  }

  Future<void> _getOrders() async {
    _uiEventController.add(LoadingUiEvent());
    final response = await _getOrdersUsecase.call();
    response.when(
      success: (ordersResponseEntity) {
        _uiEventController.add(
          SuccessUiEvent(ordersResponseEntity: ordersResponseEntity),
        );
        emit(
          state.copyWith(
            ordersState: BaseState<OrdersResponseEntity>(
              data: ordersResponseEntity,
            ),
          ),
        );
      },
      failure: (appException) {
        _uiEventController.add(ErrorUiEvent(message: appException.message));
        emit(
          state.copyWith(
            ordersState: BaseState<OrdersResponseEntity>(
              errorMessage: appException.message,
            ),
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _uiEventController.close();
    return super.close();
  }
}
