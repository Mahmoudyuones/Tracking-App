import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/di/di.dart';
import '../../../../../core/constants/app_text_string.dart';
import '../../../../../core/style/color/app_colors.dart';
import '../../../../../core/utility/ui/ui_utils.dart';
import '../../view_model/orders_cubit.dart';
import '../../view_model/orders_events.dart';
import '../../view_model/orders_state.dart';
import '../../view_model/orders_ui_events.dart';
import '../widgets/my_orders_app_bar.dart';
import '../widgets/order_card.dart';
import '../widgets/order_counters_row.dart';

class DriverOrdersScreen extends StatefulWidget {
  const DriverOrdersScreen({super.key});

  @override
  State<DriverOrdersScreen> createState() => _DriverOrdersScreenState();
}

class _DriverOrdersScreenState extends State<DriverOrdersScreen> {
  late final OrdersCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<OrdersCubit>();
    _cubit.uiEventStream.listen((event) {
      if (!mounted) return;
      switch (event) {
        case LoadingUiEvent():
          UIUtils.showEasyLoading();
        case ErrorUiEvent():
          _handleError(event.message);
        case SuccessUiEvent():
          UIUtils.hideLoading(context);
      }
    });

    _cubit.onEvent(GetOrdersEvent());
  }

  void _handleError(String message) {
    UIUtils.hideLoading(context);
    UIUtils.showMessage(
      message,
      backGroundColor: AppColors.red,
      textColor: AppColors.white,
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          final ordersState = state.ordersState;

          if (ordersState.data == null && ordersState.errorMessage == null) {
            return const SizedBox.shrink();
          }

          if (ordersState.errorMessage != null) {
            return CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(child: MyOrdersAppBar()),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline_rounded,
                          size: 48,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          ordersState.errorMessage!,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.error,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => _cubit.onEvent(GetOrdersEvent()),
                          child: Text(AppTextString.retry),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          final orders = ordersState.data!.orders ?? [];

          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: MyOrdersAppBar()),
              SliverToBoxAdapter(
                child: OrderCountersRow(
                  cancelledCount: ordersState.data!.cancelledCount,
                  completedCount: ordersState.data!.completedCount,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Text(
                    AppTextString.recentOrders,
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(fontSize: 18),
                  ),
                ),
              ),

              if (orders.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.inbox_outlined,
                          size: 54,
                          color: AppColors.lightTextSecondary,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          AppTextString.noOrdersFound,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppColors.lightTextSecondary),
                        ),
                      ],
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList.separated(
                    itemCount: orders.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(
                        bottom: index == orders.length - 1 ? 24.0 : 0,
                      ),
                      child: OrderCard(order: orders[index]),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
