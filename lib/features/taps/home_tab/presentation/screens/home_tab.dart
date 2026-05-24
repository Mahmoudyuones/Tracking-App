import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../../config/di/di.dart';
import '../../../../../core/constants/app_text_string.dart';
import '../../../../../core/gen/assets.gen.dart';
import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/style/color/app_colors.dart';
import '../../../../../core/utility/ui/ui_utils.dart';
import '../../domain/entities/response/start_order_response/start_order_response_entity.dart';
import '../cubit/home_intents.dart';
import '../cubit/home_tab_cubit.dart';
import '../cubit/home_tab_side_effects.dart';
import '../cubit/home_tab_state.dart';
import '../widgets/errors_happen_widget.dart';
import '../widgets/order_card_widget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late final HomeTabCubit _homeTabCubit;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _homeTabCubit = getIt<HomeTabCubit>();
    _homeTabCubit.sideEffects.listen((event) {
      if (mounted) {
        switch (event) {
          case LoadingSideEffect():
            UIUtils.showEasyLoading();
          case HideLoadingSideEffect():
            UIUtils.hideLoading(context);
          case ErrorToStartOrderSideEffect(message: final message):
            UIUtils.showMessage(
              message,
              backGroundColor: AppColors.error,
              textColor: AppColors.white,
            );
          case SuccessToStartOrderSideEffect(response: final response):
            _startOrder(response);
        }
      }
    });
    _scrollController.addListener(() {
      final position = _scrollController.position;
      if (position.pixels >= position.maxScrollExtent - 200) {
        _homeTabCubit.doIntent(LoadMorePendingOrdersIntent());
      }
    });
    _homeTabCubit.doIntent(GetMyProfileIntent());
    _homeTabCubit.doIntent(const GetPendingOrdersIntent(limit: 2));
  }

  void _startOrder(StartOrderResponseEntity response) {
    context.pushReplacementNamed(
      AppRoutes.startOrderDetails,
      extra: response.order,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _homeTabCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _homeTabCubit,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(Assets.icons.homeAppBarLeading.path),
              BlocBuilder<HomeTabCubit, HomeTabState>(
                builder: (context, state) {
                  if (state.getPendingOrdersState?.errorMessage != null ||
                      state.getPendingOrdersState?.isEmpty == true) {
                    return Expanded(
                      child: ErrorsOrEmptyHappenWidget(
                        text:
                            state.getPendingOrdersState?.errorMessage ??
                            AppTextString.noOrdersFound,
                        lottie:
                            state.getPendingOrdersState?.errorMessage != null
                            ? Assets.lotties.error.path
                            : Assets.lotties.empty.path,
                      ),
                    );
                  } else if (state.getPendingOrdersState?.data?.isNotEmpty ==
                      true) {
                    final orders = state.getPendingOrdersState!.data!;
                    log(
                      '${AppTextString.ordersInHomeTabLog}: ${orders.length}',
                    );
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: RefreshIndicator(
                          onRefresh: () async {
                            _homeTabCubit.doIntent(
                              const GetPendingOrdersIntent(limit: 2),
                            );
                          },
                          backgroundColor: AppColors.white,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics(),
                            ),
                            controller: _scrollController,
                            itemCount: orders.length + 1,
                            itemBuilder: (context, index) {
                              if (index == orders.length) {
                                if (state.isLoadingMore) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.gray,
                                    ),
                                  );
                                }
                                if (!state.hasMore) {
                                  return Center(
                                    child: Text(AppTextString.noMoreOrders),
                                  );
                                }
                                return const SizedBox.shrink();
                              }
                              final order = orders[index];
                              return AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child: Column(
                                  key: ValueKey(order.id),
                                  children: [
                                    OrderCardWidget(
                                      order: orders[index],
                                      onAccept: () {
                                        _homeTabCubit.doIntent(
                                          StartOrderIntent(
                                            orderId: orders[index].id,
                                            orderDetails: orders[index],
                                          ),
                                        );
                                      },
                                      onReject: () {
                                        _homeTabCubit.doIntent(
                                          RejectOrderIntent(
                                            orderId: orders[index].id,
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
