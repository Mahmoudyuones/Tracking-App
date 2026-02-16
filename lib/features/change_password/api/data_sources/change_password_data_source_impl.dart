import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../../../config/safe_api_call/safe_api_call.dart';
import '../../data/data_sources/change_password_data_source.dart';
import '../../data/models/change_password_request_model.dart';
import '../../data/models/change_password_response_model.dart';
import '../api_client/change_password_api_client.dart';

@Injectable(as: ChangePasswordDataSource)
class ChangePasswordDataSourceImpl implements ChangePasswordDataSource {
  final ChangePasswordApiClient _apiClient;

  ChangePasswordDataSourceImpl(this._apiClient);

  @override
  Future<BaseResponse<ChangePasswordResponseModel>> changePassword(
    ChangePasswordRequestModel requestModel,
  ) async {
    return safeApiCall(() => _apiClient.changePassword(requestModel));
  }
}
