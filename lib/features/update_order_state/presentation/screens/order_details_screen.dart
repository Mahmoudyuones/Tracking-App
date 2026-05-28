import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/constants/app_text_string.dart';
import '../../../../core/utility/ui/ui_utils.dart';
import '../cubit/update_order_state_cubit.dart';
import '../cubit/update_order_state_intents.dart';
import '../cubit/update_order_state_side_effects.dart';
import '../cubit/update_order_state_state.dart';
import '../widgets/order_state_details_body.dart';

class OrderStateDetailsScreen extends StatefulWidget {
  final String userId;
  final String orderId;

  const OrderStateDetailsScreen({
    super.key,
    required this.userId,
    required this.orderId,
  });

  @override
  State<OrderStateDetailsScreen> createState() =>
      _OrderStateDetailsScreenState();
}

class _OrderStateDetailsScreenState extends State<OrderStateDetailsScreen> {
  late final UpdateOrderStateCubit _cubit;
  late final StreamSubscription<UpdateOrderStateSideEffects> _sideEffectsSub;
  int? _driverSimulationStartedStep;

  @override
  void initState() {
    super.initState();
    _cubit = GetIt.instance<UpdateOrderStateCubit>();
    _sideEffectsSub = _cubit.sideEffects.listen(_handleSideEffect);
    _cubit.doIntent(
      GetOrderByOrderIdIntent(userId: widget.userId, orderId: widget.orderId),
    );
  }

  void _handleSideEffect(UpdateOrderStateSideEffects effect) {
    switch (effect) {
      case Loading():
        UIUtils.showEasyLoading();
      case HideLoading():
        UIUtils.hideLoading(context);
      case UpdateOrderStatusSuccessSideEffect():
        UIUtils.showMessage(
          AppTextString.orderStatusUpdatedSuccessfully,
          backGroundColor: Colors.green,
          textColor: Colors.white,
        );
    }
  }

  @override
  void dispose() {
    _sideEffectsSub.cancel();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          titleSpacing: 0,
          title: Text(
            AppTextString.orderDetails,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        body: BlocBuilder<UpdateOrderStateCubit, UpdateOrderStateState>(
          buildWhen: (previous, current) =>
              previous.orderDetailsState != current.orderDetailsState,
          builder: (context, state) {
            final orderDetails = state.orderDetailsState?.data;
            final errorMessage = state.orderDetailsState?.errorMessage;

            if (orderDetails == null && errorMessage == null) {
              return const SizedBox.shrink();
            }

            if (orderDetails == null && errorMessage != null) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        errorMessage,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => _cubit.doIntent(
                          GetOrderByOrderIdIntent(
                            userId: widget.userId,
                            orderId: widget.orderId,
                          ),
                        ),
                        child: Text(AppTextString.retry),
                      ),
                    ],
                  ),
                ),
              );
            }

            if ((state.currentStep == 0 || state.currentStep == 2) &&
                _driverSimulationStartedStep != state.currentStep) {
              final orderDetailsValue = orderDetails!;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                final storeLatLng = orderDetailsValue.orders.store.latLong
                    .split(',');
                final storeLatitude = double.parse(storeLatLng[0]);
                final storeLongitude = double.parse(storeLatLng[1]);
                final driverLocation = orderDetailsValue.driver.location;

                final destinationLatitude = state.currentStep == 0
                    ? storeLatitude
                    : orderDetailsValue.orders.user.location.latitude;
                final destinationLongitude = state.currentStep == 0
                    ? storeLongitude
                    : orderDetailsValue.orders.user.location.longitude;

                final startLatitude = state.currentStep == 0
                    ? driverLocation.latitude
                    : storeLatitude;
                final startLongitude = state.currentStep == 0
                    ? driverLocation.longitude
                    : storeLongitude;

                _driverSimulationStartedStep = state.currentStep;
                _cubit.doIntent(
                  StartDriverSimulationIntent(
                    storeLatitude: destinationLatitude,
                    storeLongitude: destinationLongitude,
                    startLatitude: startLatitude,
                    startLongitude: startLongitude,
                    orderId: orderDetailsValue.orders.id,
                    userId: widget.userId,
                  ),
                );
              });
            }

            return OrderStateDetailsBody(orderDetails: orderDetails!);
          },
        ),
      ),
    );
  }
}
