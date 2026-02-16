import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/forget_password/presentation/view/screens/forget_password_screen.dart';
import '../constants/app_text_string.dart';
import 'app_routes.dart';

class AppRouterConfig {
  /// GoRouter Configuration
  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.onboardingRoute,
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text(AppTextString.navigationError))),
    routes: [
      /// Navigation to Boarding Screen
      // GoRoute(
      //   path: AppRoutes.onboardingRoute,
      //   name: AppRoutes.onboardingRoute,
      //   builder: (context, state) => const TestWidget(),
      // ),
      GoRoute(
        path: AppRoutes.forgetPasswordRoute,
        name: AppRoutes.forgetPasswordRoute,
        builder: (context, state) => const ForgetPasswordScreen(),
      ),
    ],
  );
}
