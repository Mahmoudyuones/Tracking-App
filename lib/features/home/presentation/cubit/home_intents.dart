import '../../../../core/enums/home_nav_bar.dart';

sealed class HomeIntents {}

class SelectTab extends HomeIntents {
  final HomeNavBarTabs tab;

  SelectTab({required this.tab});
}
