import '../../../../config/base_state/base_state.dart';
import '../../domain/entities/driver_response_entity.dart';

class MyProfileState {
  final BaseState<DriverResponseEntity> myProfileState;

  MyProfileState({required this.myProfileState});

  MyProfileState copyWith({BaseState<DriverResponseEntity>? myProfileState}) {
    return MyProfileState(
      myProfileState: myProfileState ?? this.myProfileState,
    );
  }
}
