import 'package:flutter/material.dart';

import '../../../../../core/constants/app_text_string.dart';
import '../../../../../core/style/color/app_colors.dart';

class LogoutCard extends StatelessWidget {
  const LogoutCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        child: Row(
          children: [
            const Icon(Icons.logout_rounded, size: 20, color: AppColors.black),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                AppTextString.logoutText,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Icon(Icons.logout_rounded, size: 24, color: AppColors.black),
          ],
        ),
      ),
    );
  }
}
