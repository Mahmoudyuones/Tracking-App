import 'package:flutter/material.dart';

import '../../../../../../core/constants/app_text_string.dart';

class TextInputFieldWidget extends StatelessWidget {
  final bool isPassword;
  final bool showPassword;
  final String? Function(String?)? validator;
  final void Function()? suffixIconOnTap;
  final TextEditingController? controller;

  const TextInputFieldWidget({
    super.key,
    this.validator,
    this.showPassword = true,
    this.isPassword = false,
    this.suffixIconOnTap,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return isPassword
        ? TextFormField(
            obscureText: showPassword,
            validator: validator,
            controller: controller,
            decoration: InputDecoration(
              labelText: AppTextString.passwordLabel,
              hintText: AppTextString.enterPassword,
              suffixIcon: IconButton(
                onPressed: suffixIconOnTap,
                icon: showPassword
                    ? const Icon(Icons.visibility_off_outlined)
                    : const Icon(Icons.visibility_outlined),
              ),
            ),
            autocorrect: false,
            enableSuggestions: false,
          )
        : TextFormField(
            validator: validator,
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: AppTextString.emailLabel,
              hintText: AppTextString.enterEmail,
            ),
          );
  }
}
