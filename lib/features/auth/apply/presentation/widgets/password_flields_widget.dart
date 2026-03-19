import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_text_string.dart';
import '../../../../../core/extention/spacing.dart';
import '../../../../../core/style/color/app_colors.dart';
import '../../../../../core/validators/app_validators.dart';
import '../cubit/apply_cubit.dart';
import '../cubit/apply_intents.dart';
import '../cubit/apply_state.dart';

class PasswordFlieldsWidget extends StatelessWidget {
  const PasswordFlieldsWidget({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
  });
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(
      context,
    ).textTheme.bodyLarge?.copyWith(fontWeight: .w500, color: AppColors.black);
    return BlocBuilder<ApplyCubit, ApplyState>(
      buildWhen: (previous, current) =>
          previous.isPasswordVisible != current.isPasswordVisible ||
          previous.isConfirmPasswordVisible != current.isConfirmPasswordVisible,
      builder: (context, state) {
        return Column(
          children: [
            TextFormField(
              controller: passwordController,
              keyboardType: TextInputType.text,
              obscureText: !state.isPasswordVisible,
              decoration: InputDecoration(
                labelText: AppTextString.passwordLabel,
                suffixIcon: IconButton(
                  icon: state.isPasswordVisible
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                  onPressed: () {
                    context.read<ApplyCubit>().doIntent(
                      TogglePasswordVisibilityIntent(
                        isPasswordVisible: !state.isPasswordVisible,
                      ),
                    );
                  },
                ),
              ),
              style: textStyle,
              validator: AppValidators.validatePassword,
              onTapOutside: (_) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              onChanged: (value) {
                context.read<ApplyCubit>().doIntent(
                  ValidateFieldsIntent(password: value),
                );
              },
            ),
            24.verticalSpacing,
            TextFormField(
              controller: confirmPasswordController,
              keyboardType: TextInputType.text,
              obscureText: !state.isConfirmPasswordVisible,
              decoration: InputDecoration(
                labelText: AppTextString.confirmPasswordLabel,
                suffixIcon: IconButton(
                  icon: state.isConfirmPasswordVisible
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                  onPressed: () {
                    context.read<ApplyCubit>().doIntent(
                      ToggleConfirmPasswordVisibilityIntent(
                        isConfirmPasswordVisible:
                            !state.isConfirmPasswordVisible,
                      ),
                    );
                  },
                ),
              ),
              style: textStyle,
              validator: (value) => AppValidators.validateConfirmPassword(
                value,
                passwordController.text,
              ),
              onTapOutside: (_) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              onChanged: (value) {
                context.read<ApplyCubit>().doIntent(
                  ValidateFieldsIntent(confirmPassword: value),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
