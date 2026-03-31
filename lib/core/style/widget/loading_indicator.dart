import 'package:flutter/material.dart';

import '../color/app_colors.dart';

class LoadingIndicator extends StatelessWidget {
  final double size;

  final Color? color;
  final Color? backgroundColor;
  final double strokeWidth;

  final double? value;

  const LoadingIndicator({
    super.key,
    this.size = 36.0,
    this.color = AppColors.primary,
    this.backgroundColor,
    this.strokeWidth = 4.0,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          value: value,
          strokeWidth: strokeWidth,
          color: color ?? Theme.of(context).colorScheme.primary,
          backgroundColor: backgroundColor,
        ),
      ),
    );
  }
}
