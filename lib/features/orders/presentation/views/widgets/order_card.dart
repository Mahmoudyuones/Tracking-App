import 'package:flutter/material.dart';
import '../../../../../core/constants/app_text_string.dart';
import '../../../../../core/style/color/app_colors.dart';
import '../../../../orders/domain/entities/order_wrapper_entity.dart';
import 'order_address_info.dart';
import 'order_card_header.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order});

  final OrderWrapperEntity order;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrderCardHeader(order: order),
            const SizedBox(height: 16),
            Text(
              AppTextString.pickupAddress,
              style: Theme.of(
                context,
              ).textTheme.labelMedium!.copyWith(color: AppColors.lightTextgrey),
            ),
            const SizedBox(height: 8),
            OrderAddressInfo(
              imageUrl: order.store?.image ?? '',
              name: order.store?.name ?? '',
              address: order.store?.address ?? '',
              isStore: true,
            ),

            const SizedBox(height: 12),

            // ── User address ──
            Text(
              AppTextString.userAddress,
              style: Theme.of(
                context,
              ).textTheme.labelMedium!.copyWith(color: AppColors.lightTextgrey),
            ),
            const SizedBox(height: 8),
            OrderAddressInfo(
              imageUrl: order.order?.user?.photo ?? '',
              name:
                  '${order.order?.user?.firstName ?? ''} ${order.order?.user?.lastName ?? ''}'
                      .trim(),
              address: '',
              isStore: false,
            ),
          ],
        ),
      ),
    );
  }
}
