import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../data/models/driver_response_model.dart';
part 'my_profile_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class MyProfileApiClient {
  @factoryMethod
  factory MyProfileApiClient(Dio dio) = _MyProfileApiClient;

  @GET(ApiEndpoints.myProfile)
  Future<DriverResponseModel> getMyProfileData();

  @GET(ApiEndpoints.logout)
  Future<void> logout();
}
