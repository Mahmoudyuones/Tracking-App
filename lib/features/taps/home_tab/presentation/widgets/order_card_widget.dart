import 'package:flutter/material.dart';
import '../../../../../core/constants/api_endpoints.dart';
import '../../../../../core/constants/app_text_string.dart';
import '../../../../../core/style/color/app_colors.dart';
import '../../domain/entities/response/pending_orders_response/order_entity.dart';
import 'accept_button.dart';
import 'address_card.dart';
import 'reject_button.dart';

class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget({
    super.key,
    required this.order,
    required this.onReject,
    required this.onAccept,
  });

  final OrderEntity order;
  final VoidCallback onReject;
  final VoidCallback onAccept;

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
          AddressCard(
            image: order.store.image,
            name: order.store.name,
            address: order.store.address,
          ),
          const SizedBox(height: 14),
          Text(
            AppTextString.deliveryAddress,
            style: textTheme.titleSmall?.copyWith(color: AppColors.gray),
          ),
          const SizedBox(height: 8),
          AddressCard(
            image: '${ApiEndpoints.uploadedPhotos}${order.user.photo}',
            name: '${order.user.firstName} ${order.user.lastName}',
            address: AppTextString.defaultDeliveryAddress,
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Text(
                '${AppTextString.egp} ${order.totalPrice}',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              RejectButton(onTap: onReject),
              const SizedBox(width: 10),
              AcceptButton(onTap: onAccept),
            ],
          ),
        ],
      ),
    );
  }
}
