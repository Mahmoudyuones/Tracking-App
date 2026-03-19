import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_text_string.dart';
import '../../../../../core/extention/spacing.dart';
import '../../../../../core/style/color/app_colors.dart';
import '../../../../../core/validators/app_validators.dart';
import '../cubit/apply_cubit.dart';
import '../cubit/apply_intents.dart';

class NameFieldsWidget extends StatelessWidget {
  const NameFieldsWidget({
    super.key,
    required this.firstNameController,
    required this.secondNameController,
    required this.formKey,
  });
  final TextEditingController firstNameController;
  final TextEditingController secondNameController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(
      context,
    ).textTheme.bodyLarge?.copyWith(fontWeight: .w500, color: AppColors.black);
    return Column(
      children: [
        TextFormField(
          controller: firstNameController,
          decoration: InputDecoration(
            labelText: AppTextString.firstLegalNameLabel,
          ),
          style: textTheme,
          validator: AppValidators.validateRequired,
          onChanged: (value) {
            context.read<ApplyCubit>().doIntent(
              ValidateFieldsIntent(
                formsValid: formKey.currentState!.validate(),
              ),
            );
          },
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        ),
        24.verticalSpacing,
        TextFormField(
          controller: secondNameController,
          decoration: InputDecoration(
            labelText: AppTextString.secondLegalNameLabel,
          ),
          validator: AppValidators.validateRequired,
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          style: textTheme,
          onChanged: (value) {
            context.read<ApplyCubit>().doIntent(
              ValidateFieldsIntent(
                formsValid: formKey.currentState!.validate(),
              ),
            );
          },
        ),
      ],
    );
  }
}
