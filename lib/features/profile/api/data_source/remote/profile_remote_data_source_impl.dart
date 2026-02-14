
import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../../../../config/safe_api_call/safe_api_call.dart';
import '../../../data/data_source/profile_remote_data_source.dart';
import '../../../domain/entity/edit_profile_entity.dart';
import '../../client/profile_api_services.dart';
import '../../models/edit_profile/request/edit_vehicle_request.dart';


@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ProfileApiServices _profileApiServices;
  ProfileRemoteDataSourceImpl(this._profileApiServices);

  @override
  Future<BaseResponse<EditProfileEntity>> editVehicle(EditVehicleRequest request) {
    return safeApiCall(() async {
      final response = await _profileApiServices.editVehicle(await request.toFormDataMap());
      return response.toEntity();
    });
  }
}

