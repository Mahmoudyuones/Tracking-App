part of 'edit_profile_bloc.dart';

class EditProfileState extends Equatable {
  final EditProfileEntity? editedVehicleInfo;
  final String? editVehicleErrorMessage;
  final RequestState? editVehicleRequestState;
  const EditProfileState({
    this.editedVehicleInfo,
    this.editVehicleErrorMessage,
    this.editVehicleRequestState=RequestState.init,


  });

  EditProfileState copyWith({
    final EditProfileEntity? editedVehicleInfo,
    final String? editVehicleErrorMessage,
    final RequestState? editVehicleRequestState,

  }) {
    return EditProfileState(
      editedVehicleInfo: editedVehicleInfo??this.editedVehicleInfo,
      editVehicleErrorMessage: editVehicleErrorMessage??this.editVehicleErrorMessage,
      editVehicleRequestState: editVehicleRequestState??this.editVehicleRequestState,

    );
  }

  @override
  List<Object?> get props => [
    editVehicleErrorMessage,
    editedVehicleInfo
  ];
}
