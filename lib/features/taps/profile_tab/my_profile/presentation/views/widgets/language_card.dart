import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/constants/app_text_string.dart';
import '../../../../../../../core/style/color/app_colors.dart';
import '../../view_model/my_profile_cubit.dart';
import '../../view_model/my_profile_events.dart';

class LanguageCard extends StatelessWidget {
  const LanguageCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == AppTextString.arLangKey;

    return InkWell(
      onTap: () {
        context.read<MyProfileCubit>().onEvent(ChangeLanguageEvent());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        child: Row(
          children: [
            const Icon(
              Icons.translate_rounded,
              size: 22,
              color: AppColors.black,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                AppTextString.language,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Text(
              isArabic ? AppTextString.arabic : AppTextString.english,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}
