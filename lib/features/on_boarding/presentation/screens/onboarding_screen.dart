import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import '../../../../config/di/di.dart';
import '../../../../core/constants/app_text_string.dart';
import '../../../../core/gen/assets.gen.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/style/color/app_colors.dart';
import '../cubit/onboarding_cubit.dart';
import '../cubit/onboarding_intents.dart';
import '../cubit/onboarding_side_effects.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late final OnboardingCubit _cubit;
  @override
  void initState() {
    super.initState();
    _cubit = getIt<OnboardingCubit>();
    _cubit.onboardingSideEffects.listen((event) {
      if (!mounted) return;
      switch (event) {
        case OnboardingLoginSideEffect():
          context.pushNamed(AppRoutes.loginRoute);
        case OnboardingApplySideEffect():
          context.pushNamed(AppRoutes.applyRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Lottie.asset(
              Assets.lotties.motorcycleDelivery.path,
              width: screenSize.width * 0.4,
              height: screenSize.height * 0.4,
              fit: BoxFit.contain,
              repeat: true,
            ),
            SizedBox(height: screenSize.height * 0.02),
            Text(
              AppTextString.onboarding,
              textAlign: TextAlign.start,
              style: textStyle.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: screenSize.height * 0.04),
            ElevatedButton(
              onPressed: () {
                _cubit.doIntent(const OnboardingLoginIntent());
              },
              child: Center(
                child: Text(
                  AppTextString.login,
                  style: textStyle.titleMedium?.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: screenSize.height * 0.01),
            OutlinedButton(
              onPressed: () {
                _cubit.doIntent(const OnboardingApplyIntent());
              },
              child: Center(
                child: Text(
                  AppTextString.apply,
                  style: textStyle.titleMedium?.copyWith(color: AppColors.gray),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
