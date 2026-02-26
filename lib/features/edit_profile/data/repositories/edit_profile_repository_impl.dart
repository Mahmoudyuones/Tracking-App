import 'dart:io';
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../domain/repositories/edit_profile_repository.dart';
import '../data_sources/edit_profile_data_source.dart';
import '../models/request/edit_profile_request.dart';

@Injectable(as: EditProfileRepository)
class EditProfileRepositoryImpl implements EditProfileRepository {
  final EditProfileDataSource _dataSource;

  EditProfileRepositoryImpl(this._dataSource);

  @override
  Future<BaseResponse<void>> editProfile(EditProfileRequest request) async {
    final response = await _dataSource.editProfile(request);
    return response.when(
      success: (data) => const BaseResponse.success(null),
      failure: (exception) => BaseResponse.failure(exception),
    );
  }

  @override
  Future<BaseResponse<void>> updateProfileImage(File image) async {
    final response = await _dataSource.updateProfileImage(image);
    return response.when(
      success: (data) => const BaseResponse.success(null),
      failure: (exception) => BaseResponse.failure(exception),
    );
  }
}
