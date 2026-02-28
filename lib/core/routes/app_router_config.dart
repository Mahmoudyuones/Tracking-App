import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/change_password/presentation/view/screens/change_password_screen.dart';
import '../../features/edit_profile/presentation/screens/edit_profile_screen.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/home/presentation/cubit/home_states.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../core/enums/home_nav_bar.dart';
import '../constants/app_text_string.dart';
import 'app_routes.dart';

class AppRouterConfig {
  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.homeRoute,
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text(AppTextString.navigationError))),
    routes: [
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
        path: AppRoutes.editProfile,
        name: AppRoutes.editProfile,
        builder: (context, state) => const EditProfileScreen(),
      ),
    ],
  );
}
