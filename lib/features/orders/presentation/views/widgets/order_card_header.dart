import 'package:flutter/material.dart';
import '../../../../../core/constants/app_text_string.dart';
import '../../../../../core/style/color/app_colors.dart';
import '../../../../orders/domain/entities/order_wrapper_entity.dart';

class OrderCardHeader extends StatelessWidget {
  const OrderCardHeader({super.key, required this.order});

  final OrderWrapperEntity order;

  @override
  Widget build(BuildContext context) {
    final String status = order.order?.state ?? '';
    final bool isCompleted = status == AppTextString.completed;
    final Color statusColor = isCompleted ? AppColors.green : AppColors.red;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppTextString.flowerOrder,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Icon(
              isCompleted
                  ? Icons.check_circle_outline_rounded
                  : Icons.cancel_outlined,
              color: statusColor,
              size: 20,
            ),
            const SizedBox(width: 4),
            Text(
              isCompleted
                  ? AppTextString.completedTitle
                  : AppTextString.cancelledTitle,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: statusColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Text(
              order.order?.orderNumber ?? order.order?.id ?? '',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
