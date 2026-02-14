import 'dart:io';

import '../../../../config/base_response/base_response.dart';
import '../../api/models/edit_profile/request/edit_vehicle_request.dart';
import '../../domain/entity/edit_profile_entity.dart';



abstract interface class ProfileRemoteDataSource {

  Future<BaseResponse<EditProfileEntity>> editVehicle(EditVehicleRequest request);


}
