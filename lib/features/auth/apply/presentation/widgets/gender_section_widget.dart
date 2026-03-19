import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_text_string.dart';
import '../../../../../core/extention/spacing.dart';
import '../../../../../core/style/color/app_colors.dart';
import '../cubit/apply_cubit.dart';
import '../cubit/apply_intents.dart';
import '../cubit/apply_state.dart';

class GenderSectionWidget extends StatelessWidget {
  const GenderSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Expanded(
          child: Text(
            AppTextString.gender,
            style: textTheme.bodyLarge?.copyWith(
              fontWeight: .w600,
              color: AppColors.unselectedBottomNaVIcon,
            ),
          ),
        ),

        BlocBuilder<ApplyCubit, ApplyState>(
          builder: (context, state) {
            return Expanded(
              flex: 3,
              child: RadioGroup(
                groupValue: state.gender,
                onChanged: (value) {
                  context.read<ApplyCubit>().doIntent(
                    SelectGenderIntent(gender: value!),
                  );
                  context.read<ApplyCubit>().doIntent(
                    ValidateFieldsIntent(gender: value),
                  );
                },
                child: Row(
                  children: [
                    const Radio<String>(value: 'male'),
                    Text(AppTextString.male),
                    8.horizontalSpacing,
                    const Radio<String>(value: 'female'),
                    Text(AppTextString.female),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
