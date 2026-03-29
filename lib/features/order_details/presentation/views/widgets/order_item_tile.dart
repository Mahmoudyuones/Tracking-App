import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/app_text_string.dart';
import '../../../../../core/style/color/app_colors.dart';
import '../../../../../core/style/widget/loading_indicator.dart';
import '../../../../../features/orders/domain/entities/order_item_entity.dart';
import '../../../domain/entities/product_details_response_entity.dart';
import 'quantity_badge.dart';

class OrderItemTile extends StatelessWidget {
  const OrderItemTile({super.key, required this.item, required this.detail});

  final OrderItemEntity item;
  final ProductDetailsResponseEntity detail;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final price = item.price ?? item.product?.price ?? 0;
    final quantity = item.quantity ?? 0;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: CachedNetworkImage(
              width: 48,
              height: 48,
              imageUrl: detail.product!.imgCover,
              fit: BoxFit.cover,
              placeholder: (context, url) => const LoadingIndicator(),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.error, color: AppColors.primary),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  detail.product!.title,
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.lightTextgrey,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${AppTextString.egp} ${price.toInt()}',
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.lightTextPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          QuantityBadge(quantity: quantity),
        ],
      ),
    );
  }
}
