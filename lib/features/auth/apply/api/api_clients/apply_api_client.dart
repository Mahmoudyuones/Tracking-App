import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
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
    @Part(name: 'country') required String country,
    @Part(name: 'firstName') required String firstName,
    @Part(name: 'lastName') required String lastName,
    @Part(name: 'vehicleType') required String vehicleType,
    @Part(name: 'vehicleNumber') required String vehicleNumber,
    @Part(name: 'vehicleLicense') required MultipartFile vehicleLicense,
    @Part(name: 'NID') required String nID,
    @Part(name: 'NIDImg') required MultipartFile nIDImg,
    @Part(name: 'email') required String email,
    @Part(name: 'password') required String password,
    @Part(name: 'rePassword') required String rePassword,
    @Part(name: 'gender') required String gender,
    @Part(name: 'phone') required String phone,
  });
}
