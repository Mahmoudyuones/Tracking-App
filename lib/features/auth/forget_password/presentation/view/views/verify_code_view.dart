import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import '../../../../../../core/constants/app_text_string.dart';
import '../../../../../../core/style/color/app_colors.dart';
import '../../../../../../core/utility/ui/ui_utils.dart';
import '../../view_model/forget_password_cubit/forget_password_cubit.dart';
import '../../view_model/forget_password_cubit/forget_password_intents.dart';
import '../../view_model/forget_password_cubit/forget_password_states.dart';
import '../../view_model/forget_password_cubit/forget_password_ui_intents.dart';

class VerifyCodeView extends StatefulWidget {
  final VoidCallback onSuccess;

  const VerifyCodeView({super.key, required this.onSuccess});

  @override
  State<VerifyCodeView> createState() => VerifyCodeViewState();
}

class VerifyCodeViewState extends State<VerifyCodeView> {
  StreamSubscription? _subscription;
  final TextEditingController _otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _subscription = context.read<ForgetPasswordCubit>().uiIntents.listen((
        event,
      ) {
        if (!mounted) return;
        switch (event) {
          case ShowLoadingVerifyIntent():
            _showLoading();
          case ShowErrorMsgVerifyIntent(:final errorMessage):
            _hideLoading();
            _showError(errorMessage);
          case ShowSuccessMsgVerifyIntent(:final message):
            _hideLoading();
            _showSuccess(message);
          case NavigateToResetPasswordIntent():
            _hideLoading();
            widget.onSuccess();
          default:
            break;
        }
      });
    });
  }

  void _showSuccess(String message) {
    UIUtils.showMessage(
      message,
      backGroundColor: AppColors.green,
      textColor: AppColors.white,
    );
  }

  void _showError(String errorMessage) {
    UIUtils.showMessage(
      errorMessage,
      backGroundColor: AppColors.red,
      textColor: AppColors.white,
    );
  }

  void _hideLoading() {
    UIUtils.hideLoading(context);
  }

  void _showLoading() {
    UIUtils.showEasyLoading();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final defaultPinTheme = PinTheme(
      width: size.height * .06,
      height: size.height * .06,
      textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
        color: AppColors.gray,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.gray.withValues(alpha: .5)),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    final errorPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.red),
      borderRadius: BorderRadius.circular(12),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.primary),
      borderRadius: BorderRadius.circular(12),
    );

    final submittedPinTheme = focusedPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.primary),
    );

    return BlocBuilder<ForgetPasswordCubit, ForgetPasswordStates>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Text(
                AppTextString.emailVerificationHeader,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                AppTextString.emailVerificationTitle,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.lightTextgrey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Pinput(
                controller: _otpController,
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                errorPinTheme: errorPinTheme,
                forceErrorState: state.errorMessage != null,
                errorText: state.errorMessage,
                errorBuilder: (errorText, pin) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: AppColors.red,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          errorText ?? '',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: AppColors.red),
                        ),
                      ],
                    ),
                  );
                },
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: false,
                onChanged: (value) {
                  context.read<ForgetPasswordCubit>().doIntent(
                    OtpChangedIntent(value),
                  );
                },
                onCompleted: (pin) {
                  context.read<ForgetPasswordCubit>().doIntent(
                    SubmitCodeIntent(),
                  );
                },
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${AppTextString.didResentCode} ',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.lightTextgrey,
                      fontSize: 17,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<ForgetPasswordCubit>().doIntent(
                        ResendCodeIntent(state.email),
                      );
                    },
                    child: Text(
                      AppTextString.resend,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
