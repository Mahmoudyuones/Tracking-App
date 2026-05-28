import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../config/base_response/base_response.dart';
import '../../../../../config/base_state/base_state.dart';
import '../../../../../core/shared/entities/order_details_entity.dart';
import '../../../../../core/shared/models/location_model.dart';
import '../../../../core/constants/app_text_string.dart';
import '../../domain/usecases/change_order_status_use_case.dart';
import '../../domain/usecases/get_order_by_order_id_use_case.dart';
import '../../domain/usecases/update_driver_location_use_case.dart';
import '../../domain/usecases/update_order_status_in_firestore_use_case.dart';
import 'update_order_state_intents.dart';
import 'update_order_state_side_effects.dart';
import 'update_order_state_state.dart';

@injectable
class UpdateOrderStateCubit extends Cubit<UpdateOrderStateState> {
  UpdateOrderStateCubit(
    this._getOrderByOrderidUseCase,
    this._changeOrderStatusUseCase,
    this._updateOrderStatusInFirestoreUseCase,
    this._updateDriverLocationUseCase,
  ) : super(const UpdateOrderStateState());

  final GetOrderByOrderidUseCase _getOrderByOrderidUseCase;
  final ChangeOrderStatusUseCase _changeOrderStatusUseCase;
  final UpdateOrderStatusInFirestoreUseCase
  _updateOrderStatusInFirestoreUseCase;
  final UpdateDriverLocationUseCase _updateDriverLocationUseCase;

  final StreamController<UpdateOrderStateSideEffects> _sideEffectsController =
      StreamController<UpdateOrderStateSideEffects>.broadcast();

  Stream<UpdateOrderStateSideEffects> get sideEffects =>
      _sideEffectsController.stream;

  StreamSubscription<BaseResponse<OrderDetailsEntity>>?
  _orderDetailsSubscription;

  void doIntent(UpdateOrderStateIntents intent) {
    switch (intent) {
      case GetOrderByOrderIdIntent():
        _subscribeToOrderDetails(
          userId: intent.userId,
          orderId: intent.orderId,
        );

      case ChangeOrderStatusIntent():
        _changeOrderStatus(
          orderId: intent.orderId,
          newStatus: intent.state,
          userId: intent.userId,
        );

      case UpdateOnlyFirestoreIntent():
        _updateFirestoreOnly(
          userId: intent.userId,
          orderId: intent.orderId,
          newStatus: intent.newState,
        );

      case UpdateDriverLocationIntent():
        _updateDriverLocation(
          latitude: intent.latitude,
          longitude: intent.longitude,
          orderId: intent.orderId,
          userId: intent.userId,
        );
    }
  }

  void _emitEffect(UpdateOrderStateSideEffects effect) {
    _sideEffectsController.add(effect);
  }

  void _subscribeToOrderDetails({
    required String userId,
    required String orderId,
  }) {
    _emitEffect(const Loading());
    _orderDetailsSubscription?.cancel();
    _orderDetailsSubscription =
        _getOrderByOrderidUseCase(userId: userId, orderId: orderId).listen((
          response,
        ) {
          response.when(
            success: (orderDetails) {
              _emitEffect(const HideLoading());
              emit(
                state.copyWith(
                  orderDetailsState: BaseState<OrderDetailsEntity>(
                    data: orderDetails,
                  ),
                ),
              );
            },
            failure: (failure) {
              _emitEffect(const HideLoading());
              emit(
                state.copyWith(
                  orderDetailsState: BaseState<OrderDetailsEntity>(
                    errorMessage: failure.message,
                  ),
                ),
              );
            },
          );
        });
  }

  Future<void> _changeOrderStatus({
    required String userId,
    required String orderId,
    required String newStatus,
  }) async {
    emit(state.copyWith(loadingUpdate: true));
    final response = await _changeOrderStatusUseCase(
      orderId: orderId,
      state: state.currentStep == 0
          ? AppTextString.inProgress
          : state.currentStep == 3
          ? AppTextString.completed
          : AppTextString.canceled,
    );

    response.when(
      success: (_) async {
        final firestoreResponse = await _updateOrderStatusInFirestoreUseCase(
          userId: userId,
          orderId: orderId,
          newStatus: newStatus,
        );

        firestoreResponse.when(
          success: (_) {
            emit(
              state.copyWith(
                loadingUpdate: false,
                updateOrderStatusInFirestoreState: const BaseState<void>(
                  data: null,
                ),
                changeOrderStatusState: const BaseState<void>(data: null),
                currentStep: state.currentStep + 1,
              ),
            );
          },
          failure: (failure) {
            emit(
              state.copyWith(
                loadingUpdate: false,
                updateOrderStatusInFirestoreState: BaseState<void>(
                  errorMessage: failure.message,
                ),
              ),
            );
          },
        );
      },
      failure: (failure) {
        emit(
          state.copyWith(
            loadingUpdate: false,
            changeOrderStatusState: BaseState<void>(
              errorMessage: failure.message,
            ),
          ),
        );
      },
    );
  }

  void _updateFirestoreOnly({
    required String userId,
    required String orderId,
    required String newStatus,
  }) async {
    emit(state.copyWith(loadingUpdate: true));
    final firestoreResponse = await _updateOrderStatusInFirestoreUseCase(
      userId: userId,
      orderId: orderId,
      newStatus: newStatus,
    );

    firestoreResponse.when(
      success: (_) {
        emit(
          state.copyWith(
            loadingUpdate: false,
            updateOrderStatusInFirestoreState: const BaseState<void>(
              data: null,
            ),
            currentStep: state.currentStep + 1,
          ),
        );
      },
      failure: (failure) {
        emit(
          state.copyWith(
            loadingUpdate: false,
            updateOrderStatusInFirestoreState: BaseState<void>(
              errorMessage: failure.message,
            ),
          ),
        );
      },
    );
  }

  Future<void> _updateDriverLocation({
    required double latitude,
    required double longitude,
    required String orderId,
    required String userId,
  }) async {
    final response = await _updateDriverLocationUseCase(
      location: LocationModel(latitude: latitude, longitude: longitude),
      orderId: orderId,
      userId: userId,
    );
    response.when(
      success: (_) {
        emit(
          state.copyWith(
            updateDriverLocationState: const BaseState<void>(
              data: null,
            ),
          ),
        );
      },
      failure: (failure) {
        emit(
          state.copyWith(
            updateDriverLocationState: BaseState<void>(
              errorMessage: failure.message,
            ),
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _orderDetailsSubscription?.cancel();
    _sideEffectsController.close();
    return super.close();
  }
}
