import 'package:flutter/material.dart';

import '../../../../../core/constants/app_text_string.dart';
import '../../../../../core/extention/spacing.dart';
import '../../../../../core/style/color/app_colors.dart';

class WelcomeSectionWidget extends StatelessWidget {
  const WelcomeSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(AppTextString.welcome, style: textTheme.titleLarge),
        8.verticalSpacing,
        Text(
          AppTextString.welcomeTitle,
          style: textTheme.titleMedium?.copyWith(
            color: AppColors.lightTextgrey,
          ),
        ),
      ],
    );
  }
}
