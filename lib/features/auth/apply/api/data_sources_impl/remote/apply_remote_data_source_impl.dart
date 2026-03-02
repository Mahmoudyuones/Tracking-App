import 'package:injectable/injectable.dart';

import '../../../../../../config/base_response/base_response.dart';
import '../../../../../../config/safe_api_call/safe_api_call.dart';
import '../../../../../../core/helpers/to_multipart.dart';
import '../../../data/datasources/remote/apply_remote_data_source.dart';
import '../../../data/models/request/apply_request_model/apply_request_model.dart';
import '../../../data/models/response/apply_response_model/apply_response_model.dart';
import '../../api_clients/apply_api_client.dart';

@Injectable(as: ApplyRemoteDataSource)
class ApplyRemoteDataSourceImpl implements ApplyRemoteDataSource {
  final ApplyApiClient applyApiClient;

  ApplyRemoteDataSourceImpl(this.applyApiClient);

  @override
  Future<BaseResponse<ApplyResponseModel>> applyDriver(
    ApplyRequestModel request,
  ) {
    return safeApiCall(() async {
      final response = await applyApiClient.applyDriver(
        country: request.country,
        firstName: request.firstName,
        lastName: request.lastName,
        vehicleType: request.vehicleType,
        vehicleNumber: request.vehicleNumber,
        vehicleLicense: await toMultipartFile(request.vehicleLicense),
        nID: request.nID,
        nIDImg: await toMultipartFile(request.nIDImg),
        email: request.email,
        password: request.password,
        rePassword: request.rePassword,
        gender: request.gender,
        phone: request.phone,
      );
      return response;
    });
  }
}
