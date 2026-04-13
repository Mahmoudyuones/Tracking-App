import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/home_nav_bar.dart';
import '../../../my_profile/presentation/views/screens/my_profile_screen.dart';
import '../../../orders/presentation/views/screens/driver_orders_screen.dart';
import '../cubit/main_cubit.dart';
import '../cubit/main_intents.dart';
import '../cubit/main_states.dart';
import '../widgets/nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainStates>(
      builder: (context, state) {
        return Scaffold(
          body: _buildBody(state.currentTap),
          bottomNavigationBar: NavBar(
            currentTab: state.currentTap,
            onTabSelected: (tab) =>
                context.read<MainCubit>().doIntent(SelectTab(tab: tab)),
          ),
        );
      },
    );
  }

  Widget _buildBody(HomeNavBarTabs tab) {
    switch (tab) {
      case HomeNavBarTabs.home:
        return const Center(child: Text('Home Screen'));
      case HomeNavBarTabs.orders:
        return const DriverOrdersScreen();
      case HomeNavBarTabs.profile:
        return const MyProfileScreen();
    }
  }
}
