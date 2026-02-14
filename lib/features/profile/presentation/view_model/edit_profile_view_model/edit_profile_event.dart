part of 'edit_profile_bloc.dart';

sealed class EditProfileEvent extends Equatable {}

class EditVehicleBtnSubmitEvent extends EditProfileEvent{
  final EditVehicleRequest request;
  EditVehicleBtnSubmitEvent(this.request);

  @override
  List<Object?> get props => [request];
}








