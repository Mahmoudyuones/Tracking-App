import '../../../../core/enums/home_nav_bar.dart';

sealed class MainIntents {}

class SelectTab extends MainIntents {
  final HomeNavBarTabs tab;

  SelectTab({required this.tab});
}
