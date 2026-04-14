import 'package:flutter/material.dart';

import '../../../../../core/constants/app_text_string.dart';
import '../../../../../core/style/color/app_colors.dart';

class RejectButton extends StatelessWidget {
  const RejectButton({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.primary, width: 1.5),
        ),
        alignment: Alignment.center,
        child: Text(
          AppTextString.reject,
          style: textTheme.titleSmall?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
