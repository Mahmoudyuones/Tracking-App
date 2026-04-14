import 'dart:io';
import '../../../../../../config/base_response/base_response.dart';
import '../../data/models/request/edit_profile_request.dart';

abstract interface class EditProfileRepository {
  Future<BaseResponse<void>> editProfile(EditProfileRequest request);
  Future<BaseResponse<void>> updateProfileImage(File image);
}
