import '../../../../config/base_state/base_state.dart';
import '../../../../core/enums/home_nav_bar.dart';

class HomeStates extends BaseState<Object?> {
  final HomeNavBarTabs currentTap;

  const HomeStates({
    required this.currentTap,
    super.errorMessage,
    super.data,
    super.isEmpty,
  });

  @override
  HomeStates copyWith({
    HomeNavBarTabs? currentTap,
    String? errorMessage,
    dynamic data,
    bool? isEmpty,
  }) {
    return HomeStates(
      currentTap: currentTap ?? this.currentTap,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
      isEmpty: isEmpty ?? this.isEmpty,
    );
  }

  @override
  List<Object?> get props => [currentTap, errorMessage, isEmpty];
}
