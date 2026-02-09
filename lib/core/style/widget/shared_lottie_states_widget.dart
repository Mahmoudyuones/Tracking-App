import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../color/app_colors.dart';

class SharedLottieStatesWidget extends StatelessWidget {
  const SharedLottieStatesWidget({
    super.key,
    required this.lottie,
    required this.text,
    this.textColor,
    this.height,
    this.width,
  });

  final String lottie;
  final String text;
  final Color? textColor;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final textStyle = Theme.of(context).textTheme;
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Lottie.asset(
            lottie,
            width: width ?? screenSize.width * 0.4,
            height: height ?? screenSize.height * 0.4,
            fit: BoxFit.contain,
            repeat: true,
          ),
          Text(
            text,
            style: textStyle.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: textColor ?? AppColors.error,
            ),
          ),
        ],
      ),
    );
  }
}
