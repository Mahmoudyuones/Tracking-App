import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../core/constants/api_endpoints.dart';
import '../../login/data/models/login_request_model/login_request_model.dart';
import '../../login/data/models/login_response_model/login_response_model.dart';

part 'shared_auth_api_client.g.dart';

@injectable
@RestApi()
abstract class SharedAuthApiClient {
  @factoryMethod
  factory SharedAuthApiClient(Dio dio) = _SharedAuthApiClient;

  @POST(ApiEndpoints.loginEndPoint)
  Future<LoginResponseModel> login(@Body() LoginRequestModel body);
}
