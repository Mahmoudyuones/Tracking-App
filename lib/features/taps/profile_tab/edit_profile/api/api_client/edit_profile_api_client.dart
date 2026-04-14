import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../../core/constants/api_endpoints.dart';
import '../../data/models/request/edit_profile_request.dart';
import '../../data/models/response/edit_profile_response_model.dart';
import '../../data/models/response/upload_photo_response.dart';

part 'edit_profile_api_client.g.dart';

@injectable
@RestApi(baseUrl: ApiEndpoints.baseUrl)
abstract class EditProfileApiClient {
  @factoryMethod
  factory EditProfileApiClient(Dio dio) = _EditProfileApiClient;

  @PUT(ApiEndpoints.editProfile)
  Future<EditProfileResponseModel> editProfile(
    @Body() EditProfileRequest request,
  );

  @PUT(ApiEndpoints.updateProfileImage)
  @MultiPart()
  Future<UploadPhotoResponse> updateProfileImage(
    @Part(name: 'photo') File photo,
  );
}
