import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_text_string.dart';
import '../../../../../core/style/widget/loading_indicator.dart';
import '../../../../../features/orders/domain/entities/order_item_entity.dart';
import '../../../../../features/orders/domain/entities/order_wrapper_entity.dart';
import '../../view_model/product_details_cubit.dart';
import '../../view_model/product_details_events.dart';
import '../../view_model/product_details_state.dart';
import 'address_card.dart';
import 'order_items_list.dart';
import 'order_status_row.dart';
import 'order_summary_section.dart';
import 'store_avatar.dart';
import 'user_avatar.dart';

class OrderDetailsBody extends StatelessWidget {
  const OrderDetailsBody({
    super.key,
    required this.order,
    required this.productIds,
  });

  final OrderWrapperEntity order;
  final List<String> productIds;

  @override
  Widget build(BuildContext context) {
    final orderData = order.order;
    final store = order.store;
    final user = orderData?.user;
    final items = orderData?.orderItems ?? <OrderItemEntity>[];

    final userName = '${user?.firstName ?? ''} ${user?.lastName ?? ''}'.trim();
    final status = orderData?.state ?? '';
    final orderId = orderData?.orderNumber ?? order.id ?? '';
    final textTheme = Theme.of(context).textTheme;

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList.list(
            children: [
              const SizedBox(height: 8),
              OrderStatusRow(status: status, orderId: orderId),
              const SizedBox(height: 20),

              Text(AppTextString.pickupAddress, style: textTheme.titleMedium),
              const SizedBox(height: 8),
              AddressCard(
                leading: StoreAvatar(imageUrl: store?.image ?? ''),
                title: store?.name ?? '',
                address: store?.address ?? '',
              ),
              const SizedBox(height: 20),

              Text(AppTextString.userAddress, style: textTheme.titleMedium),
              const SizedBox(height: 8),
              AddressCard(leading: const UserAvatar(), title: userName),
              const SizedBox(height: 20),

              Text(AppTextString.orderDetails, style: textTheme.titleMedium),
              const SizedBox(height: 8),
            ],
          ),
        ),

        BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            if (state.productDetailsState.data == null &&
                state.productDetailsState.errorMessage == null) {
              return const SliverToBoxAdapter(child: LoadingIndicator());
            }

            if (state.productDetailsState.errorMessage != null &&
                (state.productDetailsState.data?.isEmpty ?? true)) {
              return SliverToBoxAdapter(
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
                        state.productDetailsState.errorMessage!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<ProductDetailsCubit>().onEvent(
                              GetMultipleProductDetailsEvent(
                                productIds: productIds,
                              ),
                            ),
                        child: Text(AppTextString.retry),
                      ),
                    ],
                  ),
                ),
              );
            }

            return OrderItemsList(
              items: items,
              productDetails: state.productDetailsState.data ?? [],
            );
          },
        ),

        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList.list(
            children: [
              const SizedBox(height: 16),
              OrderSummarySection(
                total: (orderData?.totalPrice ?? 0).toDouble(),
                paymentMethod: orderData?.paymentType ?? '',
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }
}
