import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_text_string.dart';
import '../../../../../core/extention/spacing.dart';
import '../../../../../core/gen/assets.gen.dart';
import '../../../../../core/routes/app_routes.dart';

class SucsessApplyScreen extends StatelessWidget {
  const SucsessApplyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Column(
        children: [
          const Spacer(flex: 1),
          Container(
            height: size.height * 0.2,
            width: size.width * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.images.applySuccess.path),
              ),
            ),
          ),
          Text(
            AppTextString.successApplyHeader,
            textAlign: TextAlign.center,
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          16.verticalSpacing,
          Text(
            AppTextString.successApplyTitle,
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
          ),
          16.verticalSpacing,
          SizedBox(
            width: size.width * 0.7,
            child: ElevatedButton(
              onPressed: () {
                context.go(AppRoutes.loginRoute);
              },
              child: Text(AppTextString.login),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.bottomCenter,
                  image: AssetImage(Assets.images.applySuccessFooter.path),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
