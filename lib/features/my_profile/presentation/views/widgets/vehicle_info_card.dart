import 'package:flutter/material.dart';

import '../../../../../core/constants/app_text_string.dart';
import '../../../../../core/style/color/app_colors.dart';

class VehicleInfoCard extends StatelessWidget {
  final String type;
  final String number;
  const VehicleInfoCard({super.key, required this.type, required this.number});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 108,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).dividerColor.withValues(alpha: 0.5),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppTextString.vehicleInfo,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(type, style: Theme.of(context).textTheme.labelLarge),
                  const SizedBox(height: 2),
                  Text(number, style: Theme.of(context).textTheme.labelLarge),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              size: 50,
              color: AppColors.inputBorder,
            ),
          ],
        ),
      ),
    );
  }
}
