import 'package:flutter/material.dart';
import '../../../../../../../core/constants/app_text_string.dart';

class MyOrdersAppBar extends StatelessWidget {
  const MyOrdersAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Text(
              AppTextString.myOrdersTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
