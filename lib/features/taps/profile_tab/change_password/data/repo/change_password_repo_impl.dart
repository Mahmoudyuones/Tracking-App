import 'package:injectable/injectable.dart';

import '../../../../../../config/base_response/base_response.dart';
import '../../../../../../config/cash_services/secure_storage_service.dart';
import '../../domain/entities/change_password_request_entity.dart';
import '../../domain/repo/change_password_repo.dart';
import '../data_sources/change_password_data_source.dart';
import '../mappers/change_password_request_mapper.dart';

@Injectable(as: ChangePasswordRepo)
class ChangePasswordRepoImpl implements ChangePasswordRepo {
  final ChangePasswordDataSource _dataSource;
  final SecureStorageService _secureStorageService;

  ChangePasswordRepoImpl(this._dataSource, this._secureStorageService);

  @override
  Future<BaseResponse<void>> changePassword(
    ChangePasswordRequestEntity requestEntity,
  ) async {
    final response = await _dataSource.changePassword(requestEntity.toModel());

    return response.when(
      success: (data) async {
        await _secureStorageService.saveAuthTokens(accessToken: data.token);
        return const BaseResponse<void>.success(null);
      },
      failure: (error) {
        return BaseResponse<void>.failure(error);
      },
    );
  }
}
