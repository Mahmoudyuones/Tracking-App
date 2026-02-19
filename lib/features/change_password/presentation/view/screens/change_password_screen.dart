import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../config/di/di.dart';
import '../../../../../core/constants/app_text_string.dart';
import '../../../../../core/style/color/app_colors.dart';
import '../../../../../core/utility/ui/ui_utils.dart';
import '../../../../../core/validators/app_validators.dart';
import '../../../domain/entities/change_password_request_entity.dart';
import '../../view_model/change_password_cubit.dart';
import '../../view_model/change_password_intents.dart';
import '../../view_model/change_password_states.dart';
import '../../view_model/change_pasword_ui_events.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late final ChangePasswordCubit _passwordCubit;
  final formKey = GlobalKey<FormState>();
  final _currentPassword = TextEditingController();
  final _newpassword = TextEditingController();
  final _confirmPassword = TextEditingController();
  bool _isCurrentPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  @override
  void initState() {
    super.initState();
    _passwordCubit = getIt<ChangePasswordCubit>();
    _currentPassword.addListener(_validateOnChange);
    _newpassword.addListener(_validateOnChange);
    _confirmPassword.addListener(_validateOnChange);
    _passwordCubit.uiEvents.listen((event) {
      if (!mounted) return;
      switch (event) {
        case ChangePasswordLoadingEvent():
          UIUtils.showEasyLoading();
        case ChangePasswordFailureEvent():
          _handleError(event.message);
        case ChangePasswordSuccessEvent():
          _handleSuccess();
      }
    });
  }

  void _validateOnChange() {
    _passwordCubit.doIntent(
      ValidateFields(
        password: _currentPassword.text,
        newPassword: _newpassword.text,
        confirmPassword: _confirmPassword.text,
      ),
    );
  }

  void _handleError(String message) {
    UIUtils.hideLoading(context);
    UIUtils.showMessage(
      message,
      backGroundColor: AppColors.red,
      textColor: AppColors.white,
    );
  }

  void _handleSuccess() {
    UIUtils.hideLoading(context);
    UIUtils.showMessage(
      AppTextString.loginSuccess, // Update this constant
      backGroundColor: AppColors.green,
      textColor: AppColors.white,
    );
  }

  @override
  void dispose() {
    _currentPassword.removeListener(_validateOnChange);
    _newpassword.removeListener(_validateOnChange);
    _confirmPassword.removeListener(_validateOnChange);
    _currentPassword.dispose();
    _newpassword.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _passwordCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppTextString.resetPasswordHeader),
          leading: Padding(
            padding: const EdgeInsetsDirectional.only(start: 20.0),
            child: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 10),
                TextFormField(
                  controller: _currentPassword,
                  obscureText: _isCurrentPasswordVisible == false,
                  decoration: InputDecoration(
                    label: Text(AppTextString.currentPassword),
                    hintText: AppTextString.enterCurrentPassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isCurrentPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isCurrentPasswordVisible =
                              !_isCurrentPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: AppValidators.validatePassword,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),

                const SizedBox(height: 20),
                TextFormField(
                  controller: _newpassword,
                  obscureText: _isNewPasswordVisible == false,

                  decoration: InputDecoration(
                    label: Text(AppTextString.newPassword),
                    hintText: AppTextString.enterYourNewPassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isNewPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isNewPasswordVisible = !_isNewPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) =>
                      AppValidators.validateNewPasswordIsNotTheOldPassword(
                        value,
                        _currentPassword.text,
                      ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _confirmPassword,
                  obscureText: _isConfirmPasswordVisible == false,

                  decoration: InputDecoration(
                    label: Text(AppTextString.confirmPassword),
                    hintText: AppTextString.enterConfirmPassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) => AppValidators.validateConfirmPassword(
                    value,
                    _newpassword.text,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 40),
                BlocBuilder<ChangePasswordCubit, ChangePasswordStates>(
                  builder: (context, state) {
                    return SizedBox(
                      height: 48,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: state.isValidForm
                            ? () {
                                if (formKey.currentState!.validate()) {
                                  _passwordCubit.doIntent(
                                    UpdatePasswordSubmitIntent(
                                      changePasswordRequestEntity:
                                          ChangePasswordRequestEntity(
                                            password: _currentPassword.text,
                                            newPassword: _newpassword.text,
                                          ),
                                    ),
                                  );
                                }
                              }
                            : null,
                        child: Text(
                          AppTextString.update,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
