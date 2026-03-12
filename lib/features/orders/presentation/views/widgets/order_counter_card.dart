import 'package:flutter/material.dart';
import '../../../../../core/constants/app_text_string.dart';

class OrderCounterCard extends StatelessWidget {
  const OrderCounterCard({required this.count, required this.status});

  final int count;
  final String status;

  @override
  Widget build(BuildContext context) {
    final bool isCancelled = status == AppTextString.cancelled;
    final Color bgColor = isCancelled
        ? const Color(0xFFFDE8E8)
        : const Color(0xFFE8F5E9);
    final Color iconColor = isCancelled
        ? const Color(0xFFE53935)
        : const Color(0xFF43A047);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            count.toString(),
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(
                isCancelled
                    ? Icons.cancel_outlined
                    : Icons.check_circle_outline_rounded,
                color: iconColor,
                size: 22,
              ),
              const SizedBox(width: 4),
              Text(
                isCancelled
                    ? AppTextString.cancelledTitle
                    : AppTextString.completedTitle,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: iconColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
