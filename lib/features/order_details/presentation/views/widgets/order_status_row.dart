import 'package:flutter/material.dart';

import '../../../../../core/style/color/app_colors.dart';

class OrderStatusRow extends StatelessWidget {
  const OrderStatusRow({
    super.key,
    required this.status,
    required this.orderId,
  });

  final String status;
  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: AppColors.lightTextgreen,
              size: 18,
            ),
            const SizedBox(width: 4),
            Text(
              status,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.lightTextgreen,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Text(orderId, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
