import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/home/presentation/cubit/home_states.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../core/enums/home_nav_bar.dart';
import '../constants/app_text_string.dart';
import 'app_routes.dart';

class AppRouterConfig {
  /// GoRouter Configuration
  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.homeRoute,
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
        path: AppRoutes.homeRoute,
        name: AppRoutes.homeRoute,
        builder: (context, state) => BlocProvider(
          create: (_) =>
              HomeCubit(const HomeStates(currentTap: HomeNavBarTabs.home)),
          child: const HomeScreen(),
        ),
      ),
    ],
  );
}
