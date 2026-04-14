import 'dart:io';
import '../../../../../../config/base_response/base_response.dart';
import '../models/request/edit_profile_request.dart';
import '../models/response/edit_profile_response_model.dart';
import '../models/response/upload_photo_response.dart';

abstract interface class EditProfileDataSource {
  Future<BaseResponse<EditProfileResponseModel>> editProfile(
    EditProfileRequest request,
  );
  Future<BaseResponse<UploadPhotoResponse>> updateProfileImage(File photo);
}
