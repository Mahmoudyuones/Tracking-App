import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/constants/app_text_string.dart';
import '../../../../../../core/routes/app_routes.dart';
import '../../../../../../core/style/color/app_colors.dart';
import '../../../../../../core/utility/ui/ui_utils.dart';
import '../../view_model/forget_password_cubit/forget_password_cubit.dart';
import '../../view_model/forget_password_cubit/forget_password_intents.dart';
import '../../view_model/forget_password_cubit/forget_password_states.dart';
import '../../view_model/forget_password_cubit/forget_password_ui_intents.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => ResetPasswordViewState();
}

class ResetPasswordViewState extends State<ResetPasswordView> {
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _subscription = context.read<ForgetPasswordCubit>().uiIntents.listen((
        event,
      ) {
        if (!mounted) return;
        switch (event) {
          case ShowLoadingResetPasswordIntent():
            _showLoading();
          case ShowErrorMsgResetPasswordIntent(:final errorMessage):
            _hideLoading();
            _showError(errorMessage);
          case NavigateToLoginIntent(:final message):
            _hideLoading();
            _showSuccess(message);
            _goToLogin();
          default:
            break;
        }
      });
    });
  }

  void _goToLogin() {
    context.goNamed(AppRoutes.onboardingRoute);
  }

  void _showLoading() {
    UIUtils.showEasyLoading();
  }

  void _showSuccess(String message) {
    UIUtils.showMessage(
      message,
      backGroundColor: AppColors.green,
      textColor: AppColors.white,
    );
  }

  void _hideLoading() {
    UIUtils.hideLoading(context);
  }

  void _showError(String errorMessage) {
    UIUtils.showMessage(
      errorMessage,
      backGroundColor: AppColors.red,
      textColor: AppColors.white,
    );
  }

  @override
  void dispose() {
    _newPassController.dispose();
    _confirmPassController.dispose();
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocBuilder<ForgetPasswordCubit, ForgetPasswordStates>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                AppTextString.resetPasswordHeader,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                AppTextString.resetPasswordTitle,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.lightTextgrey,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _newPassController,
                obscureText: true,
                onChanged: (value) => context
                    .read<ForgetPasswordCubit>()
                    .doIntent(NewPasswordChangedIntent(value)),
                decoration: InputDecoration(
                  labelText: AppTextString.newPasswordLabel,
                  hintText: AppTextString.enterPassword,
                ),
                style: const TextStyle(color: AppColors.black),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _confirmPassController,
                obscureText: true,
                onChanged: (value) => context
                    .read<ForgetPasswordCubit>()
                    .doIntent(ConfirmPasswordChangedIntent(value)),
                decoration: InputDecoration(
                  labelText: AppTextString.confirmPasswordLabel,
                  hintText: AppTextString.enterConfirmPassword,
                  errorText:
                      (state.confirmPassword.isNotEmpty &&
                          state.newPassword != state.confirmPassword)
                      ? AppTextString.passwordsDoNotMatch
                      : null,
                ),
                style: const TextStyle(color: AppColors.black),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: size.height * .059,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<ForgetPasswordCubit>().doIntent(
                      ConfirmResetPasswordIntent(),
                    );
                  },
                  child: Text(
                    AppTextString.confirm,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: AppColors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
