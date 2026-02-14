import 'dart:io';

import '../../../../config/base_response/base_response.dart';
import '../../api/models/edit_profile/request/edit_vehicle_request.dart';
import '../entity/edit_profile_entity.dart';


abstract interface class ProfileRepository {

 Future<BaseResponse<EditProfileEntity>> editVehicle(EditVehicleRequest request);
}
