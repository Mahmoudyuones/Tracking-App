import 'package:injectable/injectable.dart';
import '../../../../../../config/base_response/base_response.dart';
import '../../../../../../config/services/token_service.dart';
import '../../../data/datasources/local/apply_local_data_source.dart';

@Injectable(as: ApplyLocalDataSource)
class ApplyLocalDataSourceImpl implements ApplyLocalDataSource {
  final TokenService _tokenService;
  ApplyLocalDataSourceImpl(this._tokenService);
  @override
  Future<BaseResponse<void>> saveToken(String token) async {
    final response = await _tokenService.saveToken(token);
    return response.when(
      success: (success) {
        return const BaseResponse.success(null);
      },
      failure: (exception) {
        return BaseResponse.failure(exception);
      },
    );
  }
}
