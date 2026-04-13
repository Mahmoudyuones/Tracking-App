import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../../core/constants/api_endpoints.dart';
import '../../data/models/change_password_request_model.dart';
import '../../data/models/change_password_response_model.dart';
part 'change_password_api_client.g.dart';

@injectable
@RestApi(baseUrl: ApiEndpoints.baseUrl)
abstract class ChangePasswordApiClient {
  @factoryMethod
  factory ChangePasswordApiClient(Dio dio) = _ChangePasswordApiClient;

  @PATCH(ApiEndpoints.changePassword)
  Future<ChangePasswordResponseModel> changePassword(
    @Body() ChangePasswordRequestModel requestModel,
  );
}
