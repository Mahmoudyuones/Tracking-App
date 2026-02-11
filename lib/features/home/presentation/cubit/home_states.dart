import '../../../../config/base_state/base_state.dart';
import '../../../../core/enums/home_nav_bar.dart';

class HomeStates extends BaseState<void> {
  final HomeNavBarTabs currentTap;

  const HomeStates({required this.currentTap, super.errorMessage, super.data});

  @override
  HomeStates copyWith({
    HomeNavBarTabs? currentTap,
    String? errorMessage,
    dynamic data,
  }) {
    return HomeStates(
      currentTap: currentTap ?? this.currentTap,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [currentTap, errorMessage];
}
