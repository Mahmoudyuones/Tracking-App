import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../../../../core/request_state/request_state.dart';
import '../../../api/models/edit_profile/request/edit_vehicle_request.dart';
import '../../../domain/entity/edit_profile_entity.dart';
import '../../../domain/use_case/edit_vehicle_use_case.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

@injectable
class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final EditVehicleUseCase _editVehicleUseCase;
  EditProfileBloc(this._editVehicleUseCase)
    : super(const EditProfileState()) {

    on<EditVehicleBtnSubmitEvent>(_editVehicle);
  }

Future<void> _editVehicle(
    EditVehicleBtnSubmitEvent event,
    Emitter<EditProfileState> emit,
    ) async {
  emit(state.copyWith(editVehicleRequestState: RequestState.loading));
  final result = await _editVehicleUseCase.editVehicle(
      event.request);

  switch (result) {

    case Success<EditProfileEntity>():
  emit(state.copyWith(
    editVehicleRequestState: RequestState.success,
    editedVehicleInfo: result.data
  ));
    case Failure<EditProfileEntity>():
      emit(state.copyWith(
          editVehicleRequestState: RequestState.error,
       editVehicleErrorMessage: result.exception.message
      ));
  }
}


}
