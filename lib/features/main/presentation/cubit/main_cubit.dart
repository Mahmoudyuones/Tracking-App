import '../../../../core/enums/home_nav_bar.dart';
import 'main_intents.dart';
import 'main_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit(super.initialState);

  void doIntent(MainIntents intents) {
    if (intents is SelectTab) {
      _selectTab(intents.tab);
    }
  }

  void _selectTab(HomeNavBarTabs tab) {
    emit(state.copyWith(currentTap: tab));
  }
}
