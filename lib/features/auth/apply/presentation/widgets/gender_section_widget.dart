import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_text_string.dart';
import '../../../../../core/constants/validation_constants.dart';
import '../../../../../core/extention/spacing.dart';
import '../../../../../core/style/color/app_colors.dart';
import '../cubit/apply_cubit.dart';
import '../cubit/apply_intents.dart';
import '../cubit/apply_state.dart';

class GenderSectionWidget extends StatelessWidget {
  const GenderSectionWidget({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return FormField<String>(
      validator: (value) {
        if (value == null) {
          return ValidationConstants.fieldRequired;
        }
        return null;
      },
      builder: (formFieldState) {
        return InputDecorator(
          decoration: InputDecoration(
            errorText: formFieldState.errorText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: AppColors.inputBorder),
            ),
          ),
          child: Row(
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
                        formFieldState.didChange(value);
                        context.read<ApplyCubit>().doIntent(
                          ValidateFieldsIntent(
                            formsValid: formKey.currentState!.validate(),
                          ),
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
          ),
        );
      },
    );
  }
}
