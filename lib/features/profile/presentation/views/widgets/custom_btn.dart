import 'package:flutter/material.dart';

import '../../../../../core/style/color/app_colors.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({super.key,required this.onPressed,
    required this.txt,this.bg=AppColors.pink});
  final void Function()? onPressed;
  final String txt;
  final Color bg;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style:ElevatedButton.styleFrom(
            backgroundColor: bg,
            textStyle: const TextStyle(
              inherit: false,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            foregroundColor: AppColors.white,
            fixedSize: Size(MediaQuery.of(context).size.width, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(20)
            )
        ) ,
        onPressed: onPressed,
        child: Text(txt));
  }
}