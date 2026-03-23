import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_asset.dart';
import '../../../core/constants/app_text_string.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/style/color/app_colors.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Image.asset(
              AppAsset.successImage,
              key: const Key('success_image'),
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 30),
            Text(
              AppTextString.thankYou,
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.lightTextgreen,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              AppTextString.theOrderDeliveredSuccessfully,
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  key: const Key('done_button'),
                  onPressed: () {
                    context.goNamed(AppRoutes.homeRoute);
                  },
                  child: Text(AppTextString.done),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
