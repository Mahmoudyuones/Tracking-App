import 'package:flutter/material.dart';
import '../../../../../core/constants/app_text_string.dart';
import 'order_counter_card.dart';

class OrderCountersRow extends StatelessWidget {
  const OrderCountersRow({
    required this.cancelledCount,
    required this.completedCount,
  });

  final int cancelledCount;
  final int completedCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: OrderCounterCard(
              count: cancelledCount,
              status: AppTextString.cancelled,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OrderCounterCard(
              count: completedCount,
              status: AppTextString.completed,
            ),
          ),
        ],
      ),
    );
  }
}
