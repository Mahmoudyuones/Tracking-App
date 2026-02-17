import 'package:injectable/injectable.dart';

import '../../../../../../config/base_response/base_response.dart';
import '../../../../../../config/services/token_service.dart';
import '../../../data/data_sources/local/login_local_data_source.dart';

@Injectable(as: LoginLocalDataSource)
class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  final TokenService _tokenService;

  const LoginLocalDataSourceImpl(this._tokenService);

  @override
  Future<BaseResponse<void>> saveLoginData({
    required String token,
    required Map<String, dynamic> userData,
  }) async {
    final result = await _tokenService.saveLoginData(
      token: token,
      userData: userData,
    );
    return result.when(
      success: (_) => const BaseResponse.success(null),
      failure: (failure) => BaseResponse.failure(failure),
    );
  }
}
