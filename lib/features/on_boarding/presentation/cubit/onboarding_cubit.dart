import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'onboarding_intents.dart';
import 'onboarding_state.dart';
import 'onboarding_side_effects.dart';

@injectable
class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState());

  StreamController<OnboardingSideEffects> sideEffectController =
      StreamController.broadcast();

  Stream<OnboardingSideEffects> get onboardingSideEffects =>
      sideEffectController.stream;

  void doIntent(OnboardingIntents intent) {
    switch (intent) {
      case OnboardingLoginIntent():
        _login();
      case OnboardingApplyIntent():
        _apply();
    }
  }

  void _login() {
    sideEffectController.add(const OnboardingLoginSideEffect());
  }

  void _apply() {
    sideEffectController.add(const OnboardingApplySideEffect());
  }

  @override
  Future<void> close() {
    sideEffectController.close();
    return super.close();
  }
}
