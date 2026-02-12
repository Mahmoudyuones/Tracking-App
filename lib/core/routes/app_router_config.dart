import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/change_password/presentation/view/screens/change_password_screen.dart';
import '../constants/app_text_string.dart';
import 'app_routes.dart';

class AppRouterConfig {
  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.changePasswordRoute,
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text(AppTextString.navigationError))),
    routes: [
      GoRoute(
        path: AppRoutes.changePasswordRoute,
        name: AppRoutes.changePasswordRoute,
        builder: (context, state) => const ChangePasswordScreen(),
      ),
    ],
  );
}
