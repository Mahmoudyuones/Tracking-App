import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/home_nav_bar.dart';
import '../../../my_profile/presentation/views/screens/my_profile_screen.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_intents.dart';
import '../cubit/home_states.dart';
import '../widgets/nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        return Scaffold(
          body: _buildBody(state.currentTap),
          bottomNavigationBar: NavBar(
            currentTab: state.currentTap,
            onTabSelected: (tab) =>
                context.read<HomeCubit>().doIntent(SelectTab(tab: tab)),
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
        return const Center(child: Text('Orders Screen'));
      case HomeNavBarTabs.profile:
        return const MyProfileScreen();
    }
  }
}
