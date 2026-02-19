import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_text_string.dart';
import '../../../../core/enums/home_nav_bar.dart';
import '../../../../core/gen/assets.gen.dart';
import '../../../../core/style/color/app_colors.dart';

class NavBar extends StatelessWidget {
  final HomeNavBarTabs currentTab;
  final Function(HomeNavBarTabs) onTabSelected;

  const NavBar({
    super.key,
    required this.currentTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.white,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      currentIndex: HomeNavBarTabs.values.indexOf(currentTab),
      onTap: (index) => onTabSelected(HomeNavBarTabs.values[index]),
      selectedIconTheme: const IconThemeData(
        color: AppColors.primary,
        size: 24,
      ),
      unselectedIconTheme: const IconThemeData(
        color: AppColors.unselectedBottomNaVIcon,
        size: 22,
      ),
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.unselectedBottomNaVIcon,
      items: [
        _buildNavBarItem(
          tab: HomeNavBarTabs.home,
          icon: Assets.icons.icHome,
          label: AppTextString.homeNav,
        ),
        _buildNavBarItem(
          tab: HomeNavBarTabs.orders,
          icon: Assets.icons.icOrder,
          label: AppTextString.orders,
        ),
        _buildNavBarItem(
          tab: HomeNavBarTabs.profile,
          icon: Assets.icons.icPerson,
          label: AppTextString.profileNav,
        ),
      ],
    );
  }

  BottomNavigationBarItem _buildNavBarItem({
    required HomeNavBarTabs tab,
    required SvgGenImage icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        icon.path,
        width: 22,
        height: 22,
        colorFilter: ColorFilter.mode(
          currentTab == tab
              ? AppColors.primary
              : AppColors.unselectedBottomNaVIcon,
          BlendMode.srcIn,
        ),
      ),
      activeIcon: SvgPicture.asset(
        icon.path,
        width: 22,
        height: 22,
        colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
      ),
      label: label,
    );
  }
}
