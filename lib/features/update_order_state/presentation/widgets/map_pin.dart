import 'package:flutter/material.dart';

import '../../../../core/style/color/app_colors.dart';

class MapPin extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String? label;
  final Color? pinColor;
  final Color? secondPinColor;

  const MapPin({
    super.key,
    required this.color,
    required this.icon,
    this.label,
    this.pinColor,
    this.secondPinColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: color.withAlpha(90),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: AppColors.white, size: 16),
              if (label != null) ...[
                const SizedBox(width: 4),
                Text(
                  label!,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ),

        Container(
          width: 10,
          height: 10,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: pinColor ?? color,
            shape: BoxShape.circle,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: secondPinColor ?? color,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
