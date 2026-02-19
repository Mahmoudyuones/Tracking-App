import '../../../../core/enums/home_nav_bar.dart';
import 'home_intents.dart';
import 'home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit(super.initialState);

  void doIntent(HomeIntents intents) {
    if (intents is SelectTab) {
      _selectTab(intents.tab);
    }
  }

  void _selectTab(HomeNavBarTabs tab) {
    emit(state.copyWith(currentTap: tab));
  }
}
