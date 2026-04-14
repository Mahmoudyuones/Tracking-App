import 'package:flutter/material.dart';
import '../../../../../core/constants/app_text_string.dart';
import '../../../../../core/style/color/app_colors.dart';
import '../../domain/entities/response/pending_orders_response/order_entity.dart';

class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget({super.key, required this.order});

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppTextString.flowerOrder,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 14),
          Text(
            AppTextString.pickupAddress,
            style: textTheme.titleSmall?.copyWith(color: AppColors.gray),
          ),
          const SizedBox(height: 8),

          // _AddressCard(
          //   avatar: _FloweryAvatar(),
          //   name: order.storeName ?? 'Flowery store',
          //   address: order.pickupAddress ?? '20th st, Sheikh Zayed, Giza',
          // ),
          const SizedBox(height: 14),

          // User address section
          // _SectionLabel(label: 'User address'),
          const SizedBox(height: 8),

          // _AddressCard(
          //   avatar: _UserAvatar(imageUrl: order.userImageUrl),
          //   name: order.userName ?? 'Nour Mohamed',
          //   address: order.deliveryAddress ?? '20th st, Sheikh Zayed, Giza',
          // ),
          const SizedBox(height: 18),

          // Bottom row: price + action buttons
          Row(
            children: [
              Text(
                'EGP 3000',
                // 'EGP ${order.price?.toStringAsFixed(0) ?? '3000'}',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              const Spacer(),
              // _RejectButton(onTap: () {}),
              const SizedBox(width: 10),
              // _AcceptButton(onTap: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
