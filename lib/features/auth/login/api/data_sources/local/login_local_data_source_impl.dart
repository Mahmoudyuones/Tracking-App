import 'package:injectable/injectable.dart';

import '../../../../../../config/base_response/base_response.dart';
import '../../../../../../config/cash_services/secure_storage_service.dart';
import '../../../data/data_sources/local/login_local_data_source.dart';

@Injectable(as: LoginLocalDataSource)
class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  final SecureStorageService _secureStorageService;

  const LoginLocalDataSourceImpl(this._secureStorageService);

  @override
  Future<BaseResponse<void>> saveLoggedUserData({required String token}) async {
    final result = await _secureStorageService.saveAuthTokens(
      accessToken: token,
    );
    return result.when(
      success: (_) => const BaseResponse.success(null),
      failure: (failure) => BaseResponse.failure(failure),
    );
  }
}
