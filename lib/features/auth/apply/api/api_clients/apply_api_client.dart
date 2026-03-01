import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import '../../../../../core/constants/api_endpoints.dart';
import '../../data/models/response/apply_response_model/apply_response_model.dart';
part 'apply_api_client.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiEndpoints.baseUrl)
abstract class ApplyApiClient {
  @factoryMethod
  factory ApplyApiClient(Dio dio) = _ApplyApiClient;

  @POST(ApiEndpoints.apply)
  @MultiPart()
  Future<ApplyResponseModel> applyDriver({
    @Part(name: 'country') String country,
    @Part(name: 'firstName') String firstName,
    @Part(name: 'lastName') String lastName,
    @Part(name: 'vehicleType') String vechicleType,
    @Part(name: 'vehicleNumber') String vechicleNumber,
    @Part(name: 'vehicleLicense') MultipartFile vehicleLicense,
    @Part(name: 'NID') String nID,
    @Part(name: 'NIDImg') MultipartFile nIDImg,
    @Part(name: 'email') String email,
    @Part(name: 'password') String password,
    @Part(name: 'rePassword') String rePassword,
    @Part(name: 'gender') String gender,
    @Part(name: 'phone') String phone,
  });
}
