import 'dart:io';
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../api/models/edit_profile/request/edit_vehicle_request.dart';
import '../../domain/entity/edit_profile_entity.dart';
import '../../domain/repository/profile_repository.dart';
import '../data_source/profile_remote_data_source.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _profileRemoteDataSource;
  ProfileRepositoryImpl(this._profileRemoteDataSource);

  @override
  Future<BaseResponse<EditProfileEntity>> editVehicle(EditVehicleRequest request) async{
    return await _profileRemoteDataSource.editVehicle(request);
  }




}
