import 'package:flutter/material.dart';

import '../../../../../core/constants/app_text_string.dart';
import '../../../../../features/orders/domain/entities/order_item_entity.dart';
import '../../../../../features/orders/domain/entities/order_wrapper_entity.dart';
import 'address_card.dart';
import 'order_items_list.dart';
import 'order_status_row.dart';
import 'order_summary_section.dart';
import 'store_avatar.dart';
import 'user_avatar.dart';

class OrderDetailsBody extends StatelessWidget {
  const OrderDetailsBody({super.key, required this.order});

  final OrderWrapperEntity order;

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
              AddressCard(
                leading: UserAvatar(avatarUrl: user?.photo ?? ''),
                title: userName,
              ),
              const SizedBox(height: 20),

              Text(AppTextString.orderDetails, style: textTheme.titleMedium),
              const SizedBox(height: 8),
            ],
          ),
        ),

        OrderItemsList(items: items),

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
