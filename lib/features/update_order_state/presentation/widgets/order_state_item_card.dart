import 'package:flutter/material.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/constants/app_text_string.dart';
import '../../../../core/shared/entities/order_data_entity.dart';
import '../../../../core/style/color/app_colors.dart';
import 'order_item_avatar_in_update_state.dart';

class OrderStateItemCard extends StatelessWidget {
  const OrderStateItemCard({super.key, required this.item});

  final OrderItemsEntity item;

  @override
  Widget build(BuildContext context) {
    final product = item.product;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightTextSecondary, width: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          OrderItemAvatarInUpdateState(
            imageUrl: '${ApiEndpoints.basePhoto}${product.imgCover}',
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${AppTextString.egp} ${item.product.priceAfterDiscount}',
                  style: textTheme.bodySmall?.copyWith(color: AppColors.black),
                ),
              ],
            ),
          ),
          Text(
            'x${item.quantity}',
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
