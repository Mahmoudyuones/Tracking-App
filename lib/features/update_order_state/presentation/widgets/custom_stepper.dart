import 'package:flutter/material.dart';

import '../../../../core/style/color/app_colors.dart';

class CustomStepper extends StatefulWidget {
  final int currentStep;

  const CustomStepper({super.key, required this.currentStep});

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        final isCompleted = index < widget.currentStep;
        final isActive = index == widget.currentStep;

        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            height: 4,
            decoration: BoxDecoration(
              color: isCompleted || isActive
                  ? AppColors.green
                  : AppColors.lightGrey,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }
}
