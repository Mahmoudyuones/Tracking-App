import 'package:flutter/material.dart';

import '../../../../../core/style/color/app_colors.dart';

class CustomTxtField extends StatelessWidget {
  const CustomTxtField({
    super.key,
    required this.hintTxt,
    required this.lbl,
    required this.controller,
    required this.validator,
     this.isPassword=false,

  });
final String hintTxt;final String lbl;
final TextEditingController controller;
 final String? Function(String?)? validator;
final bool isPassword;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      obscuringCharacter: "*",
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintTxt,
        labelText: lbl,
        labelStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            color: AppColors.gray,fontSize: 14),
        hintStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            color: AppColors.lightTextSecondary,
            fontSize: 14.0),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide:const BorderSide(
                color: AppColors.gray
            )
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide:const  BorderSide(
                color: AppColors.gray
            )
        ),
        border: OutlineInputBorder(
borderRadius: BorderRadius.circular(4.0),
          borderSide:const BorderSide(
            color: AppColors.gray
          )
        )
      ),
    );
  }
}
