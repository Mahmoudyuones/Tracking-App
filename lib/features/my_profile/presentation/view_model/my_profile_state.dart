import '../../../../config/base_state/base_state.dart';
import '../../domain/entities/driver_response_entity.dart';

class MyProfileState {
  final BaseState<DriverResponseEntity> myProfileState;
  final BaseState<void> logoutState;

  MyProfileState({required this.myProfileState, required this.logoutState});

  MyProfileState copyWith({
    BaseState<DriverResponseEntity>? myProfileState,
    BaseState<void>? logoutState,
  }) {
    return MyProfileState(
      myProfileState: myProfileState ?? this.myProfileState,
      logoutState: logoutState ?? this.logoutState,
    );
  }
}
