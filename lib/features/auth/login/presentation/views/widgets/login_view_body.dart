import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/constants/app_text_string.dart';
import '../../../../../../core/extention/spacing.dart';
import '../../../../../../core/routes/app_routes.dart';
import '../../../../../../core/style/color/app_colors.dart';
import '../../../../../../core/utility/ui/ui_utils.dart';
import '../../../../../../core/validators/app_validators.dart';
import '../../view_models/login_cubit.dart';
import '../../view_models/login_events.dart';
import '../../view_models/login_state.dart';
import 'remember_and_forget_widget.dart';
import 'text_input_filed_widget.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  late TextEditingController emailCtr;
  late TextEditingController passwordCtr;
  late GlobalKey<FormState> globalKey;
  late LoginCubit cubit;
  StreamSubscription<LoginEffect>? _effectsSubscription;
  bool _isButtonEnabled = true;
  bool _hasPressedButton = false;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    cubit = context.read<LoginCubit>();
    emailCtr = TextEditingController();
    passwordCtr = TextEditingController();
    globalKey = GlobalKey<FormState>();
    _effectsSubscription = cubit.effects.listen((effect) {
      if (mounted) _handleEffects(effect);
    });
  }

  void _handleEffects(LoginEffect effect) {
    switch (effect) {
      case NavigateToHomeEffect():
        context.goNamed(AppRoutes.homeRoute);
      case NavigateToForgetPasswordEffect():
        context.pushNamed(AppRoutes.forgetPasswordRoute);
      case ShowErrorEffect():
        UIUtils.showMessage(
          effect.message,
          backGroundColor: AppColors.red,
          textColor: AppColors.white,
        );
      case LoadingEffect():
        if (effect.isLoading) {
          UIUtils.showEasyLoading(status: AppTextString.loading);
        } else {
          EasyLoading.dismiss();
        }
    }
  }

  @override
  void dispose() {
    _effectsSubscription?.cancel();
    emailCtr.dispose();
    passwordCtr.dispose();
    super.dispose();
  }

  void _validateSignInForm() {
    final bool isFormValid = globalKey.currentState?.validate() ?? false;
    if (isFormValid != _isButtonEnabled) {
      setState(() => _isButtonEnabled = isFormValid);
    }
  }

  void _submitLogin() {
    final bool isFormValid = globalKey.currentState?.validate() ?? false;
    setState(() => _hasPressedButton = true);
    if (isFormValid) {
      cubit.doIntent(
        SubmitLoginIntent(
          email: emailCtr.text,
          password: passwordCtr.text,
          rememberMe: cubit.state.isRememberMe,
        ),
      );
    } else {
      setState(() => _isButtonEnabled = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Form(
        onChanged: _hasPressedButton ? _validateSignInForm : null,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: globalKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            TextInputFiledWidget(
              validator: AppValidators.validateEmail,
              controller: emailCtr,
            ),
            24.verticalSpacing,
            TextInputFiledWidget(
              isPassword: true,
              showPassword: !_isPasswordVisible,
              validator: AppValidators.validateLoginPassword,
              controller: passwordCtr,
              suffixIconOnTap: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
            12.verticalSpacing,
            BlocBuilder<LoginCubit, LoginStates>(
              buildWhen: (prev, current) =>
                  prev.isRememberMe != current.isRememberMe,
              builder: (context, state) {
                return CustomRememberAndForget(
                  onPressed: () =>
                      cubit.doIntent(NavigateToForgetPasswordIntent()),
                );
              },
            ),
            32.verticalSpacing,
            BlocBuilder<LoginCubit, LoginStates>(
              buildWhen: (prev, current) => prev.isLoading != current.isLoading,
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: _isButtonEnabled && !state.isLoading
                      ? _submitLogin
                      : null,
                  child: Text(AppTextString.login),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
