import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../api/models/edit_profile/request/edit_vehicle_request.dart';
import '../entity/edit_profile_entity.dart';
import '../repository/profile_repository.dart';
@injectable
class EditVehicleUseCase{
final ProfileRepository _profileRepository;
const EditVehicleUseCase(this._profileRepository);
  Future<BaseResponse<EditProfileEntity>>
  editVehicle(EditVehicleRequest request)async{
    return await _profileRepository.editVehicle(request);
  }
}