import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_text_string.dart';
import '../../../../../core/style/color/app_colors.dart';
import '../../view_model/my_profile_cubit.dart';
import '../../view_model/my_profile_events.dart';

class LogoutCard extends StatelessWidget {
  const LogoutCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.read<MyProfileCubit>().onEvent(LogoutEvent()),
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
