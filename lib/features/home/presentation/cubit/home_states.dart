import '../../../../config/base_state/base_state.dart';
import '../../../../core/enums/home_nav_bar.dart';

class HomeStates extends BaseState<void> {
  final HomeNavBarTabs currentTap;

  const HomeStates({
    required this.currentTap,
    super.errorMessage,
    super.isEmpty,
  });

  @override
  HomeStates copyWith({
    HomeNavBarTabs? currentTap,
    String? errorMessage,
    void data,
    bool? isEmpty,
  }) {
    return HomeStates(
      currentTap: currentTap ?? this.currentTap,
      errorMessage: errorMessage ?? this.errorMessage,
      isEmpty: isEmpty ?? this.isEmpty,
    );
  }

  @override
  List<Object?> get props => [currentTap, errorMessage, isEmpty];
}
