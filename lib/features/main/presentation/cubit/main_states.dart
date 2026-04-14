import '../../../../config/base_state/base_state.dart';
import '../../../../core/enums/home_nav_bar.dart';

class MainStates extends BaseState<Object?> {
  final HomeNavBarTabs currentTap;

  const MainStates({
    required this.currentTap,
    super.errorMessage,
    super.isEmpty,
  });

  @override
  MainStates copyWith({
    HomeNavBarTabs? currentTap,
    String? errorMessage,
    void data,
    bool? isEmpty,
  }) {
    return MainStates(
      currentTap: currentTap ?? this.currentTap,
      errorMessage: errorMessage ?? this.errorMessage,
      isEmpty: isEmpty ?? this.isEmpty,
    );
  }

  @override
  List<Object?> get props => [currentTap, errorMessage, isEmpty];
}
