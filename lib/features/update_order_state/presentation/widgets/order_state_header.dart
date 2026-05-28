import 'package:flutter/material.dart';
import '../../../../core/constants/app_text_string.dart';
import '../../../../core/style/color/app_colors.dart';

class OrderStateHeader extends StatelessWidget {
  const OrderStateHeader({
    super.key,
    required this.statusLabel,
    required this.orderId,
    required this.orderDate,
  });

  final String statusLabel;
  final String orderId;
  final String orderDate;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
        color: AppColors.lightPink,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${AppTextString.status} ${statusLabel[0].toUpperCase()}${statusLabel.substring(1)}',
              style: textTheme.bodyLarge?.copyWith(
                color: AppColors.lightTextgreen,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${AppTextString.orderIdLabel} $orderId',
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 4),
            Text(
              '${AppTextString.orderDateLabel} ${orderDate.length >= 16 ? orderDate.substring(0, 16) : orderDate}',
              style: textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
