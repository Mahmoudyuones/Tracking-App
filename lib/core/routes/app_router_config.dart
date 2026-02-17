import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/base_response/base_response.dart';
import '../../config/di/di.dart';
import '../../config/services/session_manager_service.dart';
import '../../config/services/token_service.dart';
import '../../features/auth/login/presentation/views/login_view.dart';
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
        path: AppRoutes.loginRoute,
        name: AppRoutes.loginRoute,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: AppRoutes.homeRoute,
        name: AppRoutes.homeRoute,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Home'))),
      ),
    ],
    // REDIRECT LOGIC FOR APP ENTRY
    redirect: _isLoggedIn,
    refreshListenable: GoRouterRefreshStream(
      getIt<SessionManagerService>().sessionExpiredStream,
    ),
  );

  static FutureOr<String?> _isLoggedIn(
    BuildContext cont,
    GoRouterState state,
  ) async {
    final tokenService = getIt<TokenService>();
    final loginStatus = await tokenService.isLoggedIn();
    bool isLoggedIn = false;
    loginStatus.when(
      success: (val) => isLoggedIn = val,
      failure: (_) => isLoggedIn = false,
    );
    final isLoggingIn = state.matchedLocation == AppRoutes.loginRoute;
    if (!isLoggedIn) {
      // If not logged in and not already on login page, go to login
      return isLoggingIn ? null : AppRoutes.loginRoute;
    }
    if (isLoggedIn && isLoggingIn) {
      // If logged in and trying to go to login, redirect to home
      return AppRoutes.homeRoute;
    }
    return null;
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
