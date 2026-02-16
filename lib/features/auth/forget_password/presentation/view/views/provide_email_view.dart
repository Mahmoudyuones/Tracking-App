import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/constants/app_text_string.dart';
import '../../../../../../core/style/color/app_colors.dart';
import '../../../../../../core/utility/ui/ui_utils.dart';
import '../../view_model/forget_password_cubit/forget_password_cubit.dart';
import '../../view_model/forget_password_cubit/forget_password_intents.dart';
import '../../view_model/forget_password_cubit/forget_password_states.dart';
import '../../view_model/forget_password_cubit/forget_password_ui_intents.dart';

class ProvideEmailView extends StatefulWidget {
  final Function(String) onSuccess;

  const ProvideEmailView({super.key, required this.onSuccess});

  @override
  State<ProvideEmailView> createState() => ProvideEmailViewState();
}

class ProvideEmailViewState extends State<ProvideEmailView> {
  final TextEditingController _emailController = TextEditingController();
  StreamSubscription? _subscription;

  @override
  void dispose() {
    _emailController.dispose();
    _subscription?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _subscription = context.read<ForgetPasswordCubit>().uiIntents.listen((
        event,
      ) {
        if (!mounted) return;
        switch (event) {
          case ShowLoadingProvideEmailIntent():
            UIUtils.showEasyLoading();
          case ShowErrorProvideEmailIntent(:final errorMessage):
            UIUtils.hideLoading(context);
            UIUtils.showMessage(
              errorMessage,
              backGroundColor: AppColors.red,
              textColor: AppColors.white,
            );
          case NavigateToVerifyIntent():
            UIUtils.hideLoading(context);
            widget.onSuccess(_emailController.text);
          default:
            break;
        }
      });
    });
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
                AppTextString.forgetPasswordHeader,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                AppTextString.forgetPasswordTitle,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppColors.lightTextgrey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: size.height * 0.039),
              TextField(
                controller: _emailController,
                onChanged: (value) => context
                    .read<ForgetPasswordCubit>()
                    .doIntent(EmailChangedIntent(value)),
                decoration: InputDecoration(
                  labelText: AppTextString.emailLabel,
                  hintText: AppTextString.enterEmail,
                  hoverColor: AppColors.black,
                ),
                style: const TextStyle(color: AppColors.black),
              ),
              SizedBox(height: size.height * 0.059),
              SizedBox(
                height: size.height * 0.059,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<ForgetPasswordCubit>().doIntent(
                      ConfirmEmailIntent(),
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
