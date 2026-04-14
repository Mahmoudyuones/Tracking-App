import 'dart:io';

import 'package:injectable/injectable.dart';

import '../../../../../../config/base_response/base_response.dart';
import '../../../../../../config/safe_api_call/safe_api_call.dart';
import '../../data/data_sources/edit_profile_data_source.dart';
import '../../data/models/request/edit_profile_request.dart';
import '../../data/models/response/edit_profile_response_model.dart';
import '../../data/models/response/upload_photo_response.dart';
import '../api_client/edit_profile_api_client.dart';

@Injectable(as: EditProfileDataSource)
class EditProfileDataSourceImpl implements EditProfileDataSource {
  final EditProfileApiClient _apiClient;

  EditProfileDataSourceImpl(this._apiClient);
  @override
  Future<BaseResponse<EditProfileResponseModel>> editProfile(
    EditProfileRequest request,
  ) {
    return safeApiCall<EditProfileResponseModel>(() {
      return _apiClient.editProfile(request);
    });
  }

  @override
  Future<BaseResponse<UploadPhotoResponse>> updateProfileImage(File photo) {
    return safeApiCall<UploadPhotoResponse>(() {
      return _apiClient.updateProfileImage(photo);
    });
  }
}
