import 'dart:io';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../models/edit_profile/request/edit_vehicle_request.dart';
import '../models/edit_profile/response/edit_profile_response.dart';
part 'profile_api_services.g.dart';
@RestApi(baseUrl:ApiEndpoints.baseUrl)
@injectable
abstract class ProfileApiServices {
  @factoryMethod
  factory ProfileApiServices(Dio dio) = _ProfileApiServices;

  @PUT(ApiEndpoints.editDriverProfile)
  @MultiPart()
  Future<EditProfileResponse> editVehicle
      (@Body() Map<String, dynamic> body);


}
