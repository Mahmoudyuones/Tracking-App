import 'package:flutter/material.dart';

import '../../../../../../core/constants/app_text_string.dart';
import '../../../../../../core/style/color/app_colors.dart';

class CustomRememberAndForget extends StatefulWidget {
  const CustomRememberAndForget({super.key, this.onPressed});
  final void Function()? onPressed;

  @override
  State<CustomRememberAndForget> createState() =>
      _CustomRememberAndForgetState();
}

class _CustomRememberAndForgetState extends State<CustomRememberAndForget> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0,
      isThreeLine: false,
      contentPadding: EdgeInsets.zero,
      leading: Checkbox(
        activeColor: AppColors.primary,
        value: isSelected,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(2),
        ),
        side: const BorderSide(color: AppColors.gray, width: 2),
        onChanged: (value) async {
          setState(() => isSelected = !isSelected);
        },
      ),
      title: Text(AppTextString.rememberMe),
      trailing: TextButton(
        onPressed: widget.onPressed,
        child: Text(AppTextString.didForgetPassword),
      ),
    );
  }
}
