import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../config/base_response/base_response.dart';
import '../../config/di/di.dart';
import '../../config/services/session_manager_service.dart';
import '../../config/services/token_service.dart';
import '../../core/enums/home_nav_bar.dart';
import '../../features/auth/apply/presentation/screens/apply_screen.dart';
import '../../features/auth/apply/presentation/screens/sucsess_apply_screen.dart';
import '../../features/auth/login/presentation/views/login_view.dart';
import '../../features/taps/home_tab/domain/entities/response/start_order_response/start_order_entity.dart';
import '../../features/taps/profile_tab/change_password/presentation/view/screens/change_password_screen.dart';
import '../../features/taps/profile_tab/edit_profile/presentation/view/screens/edit_profile_screen.dart';
import '../../features/main/presentation/cubit/main_cubit.dart';
import '../../features/main/presentation/cubit/main_states.dart';
import '../../features/main/presentation/screens/main_screen.dart';
import '../../features/auth/forget_password/presentation/view/screens/forget_password_screen.dart';
import '../../features/taps/profile_tab/my_profile/domain/entities/driver_entity.dart';
import '../../features/on_boarding/presentation/screens/onboarding_screen.dart';
import '../../features/taps/orders_tap/orders/domain/entities/order_wrapper_entity.dart';
import '../../features/taps/orders_tap/order_details/presentation/views/screens/driver_order_details_screen.dart';
import '../../features/sucsess/presenatation/success_sccreen.dart';
import '../../features/update_order_state/presentation/screens/order_details_screen.dart';
import '../constants/app_text_string.dart';
import 'app_routes.dart';

class AppRouterConfig {
  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.onBoardingRoute,
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text(AppTextString.navigationError))),
    routes: [
      //==========================OnBoarding Route========================================
      GoRoute(
        path: AppRoutes.onBoardingRoute,
        name: AppRoutes.onBoardingRoute,
        builder: (context, state) => const OnBoardingScreen(),
      ),
      //==========================Auth Routes========================================
      GoRoute(
        path: AppRoutes.applyRoute,
        name: AppRoutes.applyRoute,
        builder: (context, state) => const ApplyScreen(),
      ),
      GoRoute(
        path: AppRoutes.successApplyRoute,
        name: AppRoutes.successApplyRoute,
        builder: (context, state) => const SucsessApplyScreen(),
      ),
      GoRoute(
        path: AppRoutes.loginRoute,
        name: AppRoutes.loginRoute,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: AppRoutes.forgetPasswordRoute,
        name: AppRoutes.forgetPasswordRoute,
        builder: (context, state) => const ForgetPasswordScreen(),
      ),
      //==========================Profile Route========================================
      GoRoute(
        path: AppRoutes.changePasswordRoute,
        name: AppRoutes.changePasswordRoute,
        builder: (context, state) => const ChangePasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.editProfile,
        name: AppRoutes.editProfile,
        builder: (context, state) {
          final driver = state.extra as DriverEntity;
          return EditProfileScreen(driver: driver);
        },
      ),
      //==========================Main App Route========================================
      GoRoute(
        path: AppRoutes.mainRoute,
        name: AppRoutes.mainRoute,
        builder: (context, state) => BlocProvider(
          create: (_) =>
              MainCubit(const MainStates(currentTap: HomeNavBarTabs.home)),
          child: const MainScreen(),
        ),
      ),

      GoRoute(
        path: AppRoutes.driverOrderDetails,
        name: AppRoutes.driverOrderDetails,
        builder: (context, state) {
          final order = state.extra as OrderWrapperEntity;
          return OrderDetailsScreen(order: order);
        },
      ),

      GoRoute(
        path: AppRoutes.successRoute,
        name: AppRoutes.successRoute,
        builder: (context, state) => const SuccessScreen(),
      ),

      GoRoute(
        path: AppRoutes.orderDetails,
        name: AppRoutes.orderDetails,
        builder: (context, state) {
          final order = state.extra as StartOrderEntity;

          return OrderStateDetailsScreen(
            orderId: order.id,
            userId: order.userId,
          );
        },
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

    final isPublicRoute =
        state.matchedLocation == AppRoutes.applyRoute ||
        state.matchedLocation == AppRoutes.loginRoute ||
        state.matchedLocation == AppRoutes.successApplyRoute ||
        state.matchedLocation == AppRoutes.forgetPasswordRoute;

    if (!isLoggedIn && !isPublicRoute) {
      return AppRoutes.onBoardingRoute;
    }

    if (isLoggedIn &&
        (state.matchedLocation == AppRoutes.loginRoute ||
            state.matchedLocation == AppRoutes.onBoardingRoute)) {
      return AppRoutes.mainRoute;
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
