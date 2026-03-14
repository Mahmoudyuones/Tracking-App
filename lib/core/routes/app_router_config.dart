import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../config/base_response/base_response.dart';
import '../../config/di/di.dart';
import '../../config/services/token_service.dart';
import '../../core/enums/home_nav_bar.dart';
import '../../features/auth/login/presentation/views/login_view.dart';
import '../../features/change_password/presentation/view/screens/change_password_screen.dart';
import '../../features/edit_profile/presentation/view/screens/edit_profile_screen.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/home/presentation/cubit/home_states.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/auth/forget_password/presentation/view/screens/forget_password_screen.dart';
import '../../features/my_profile/domain/entities/driver_entity.dart';
import '../../features/sucsess/presenatation/success_sccreen.dart';
import '../constants/app_text_string.dart';
import 'app_routes.dart';

class AppRouterConfig {
  /// GoRouter Configuration
  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.loginRoute,
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text(AppTextString.navigationError))),
    routes: [
      /// Navigation to Boarding Screen
      // GoRoute(
      //   path: AppRoutes.onboardingRoute,
      //   name: AppRoutes.onboardingRoute,
      //   builder: (context, state) => const TestWidget()
      // ),
      GoRoute(
        path: AppRoutes.changePasswordRoute,
        name: AppRoutes.changePasswordRoute,
        builder: (context, state) => const ChangePasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.homeRoute,
        name: AppRoutes.homeRoute,
        builder: (context, state) => BlocProvider(
          create: (_) =>
              HomeCubit(const HomeStates(currentTap: HomeNavBarTabs.home)),
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.forgetPasswordRoute,
        name: AppRoutes.forgetPasswordRoute,
        builder: (context, state) => const ForgetPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.editProfile,
        name: AppRoutes.editProfile,
        builder: (context, state) {
          final driver = state.extra as DriverEntity;
          return EditProfileScreen(driver: driver);
        },
      ),
      GoRoute(
        path: AppRoutes.loginRoute,
        name: AppRoutes.loginRoute,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: AppRoutes.successRoute,
        name: AppRoutes.successRoute,
        builder: (context, state) => const SuccessScreen(),
      ),
    ],
    // REDIRECT LOGIC FOR APP ENTRY
    redirect: _isLoggedIn,
    // refreshListenable: GoRouterRefreshStream(
    //   getIt<SessionManagerService>().sessionExpiredStream,
    // ),
  );

  static FutureOr<String?> _isLoggedIn(
    BuildContext cont,
    GoRouterState state,
  ) async {
    final tokenService = getIt<TokenService>();
    final loginStatus = await tokenService.isLoggedIn();
    log('>>>>>>>>$loginStatus', name: 'Login Status');
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
