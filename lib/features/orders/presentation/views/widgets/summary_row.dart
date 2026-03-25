import 'package:flutter/material.dart';

import '../../../../../core/style/color/app_colors.dart';

class SummaryRow extends StatelessWidget {
  const SummaryRow({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: AppColors.inputBorder),
          ),
        ],
      ),
    );
  }
}
