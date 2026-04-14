import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../core/constants/app_text_string.dart';
import '../../../../../../../core/style/color/app_colors.dart';
import 'language_option.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.whiteLight,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.translate_rounded,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  AppTextString.chooseLanguage,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(height: 1, color: AppColors.whiteLight),
            const SizedBox(height: 12),
            LanguageOption(
              label: AppTextString.english,
              isSelected:
                  context.locale.languageCode == AppTextString.enLangKey,
              onTap: () {
                context.setLocale(const Locale(AppTextString.enLangKey));
                context.pop();
              },
            ),
            const SizedBox(height: 10),
            LanguageOption(
              label: AppTextString.arabic,
              isSelected:
                  context.locale.languageCode == AppTextString.arLangKey,
              onTap: () {
                context.setLocale(const Locale(AppTextString.arLangKey));
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
