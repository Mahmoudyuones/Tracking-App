import '../../../../../config/base_state/base_state.dart';

class ApplyState {
  final BaseState? applyState;
  const ApplyState({this.applyState});

  ApplyState copyWith({BaseState? applyState}) {
    return ApplyState(applyState: applyState ?? this.applyState);
  }
}
