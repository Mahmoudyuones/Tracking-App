import 'package:injectable/injectable.dart';
import '../../../../../config/base_response/base_response.dart';
import '../../domain/entities/request/apply_request_entity.dart';
import '../../domain/repositories/apply_repository.dart';
import '../datasources/local/apply_local_data_source.dart';
import '../datasources/remote/apply_remote_data_source.dart';
import '../mappers/request/apply_request_mapper.dart';

@Injectable(as: ApplyRepository)
class ApplyRepositoryImpl implements ApplyRepository {
  final ApplyRemoteDataSource _applyRemoteDataSource;
  final ApplyLocalDataSource _applyLocalDataSource;
  ApplyRepositoryImpl(this._applyRemoteDataSource, this._applyLocalDataSource);
  @override
  Future<BaseResponse<String>> apply(
    ApplyRequestEntity applyRequestEntity,
  ) async {
    final remoteResponse = await _applyRemoteDataSource.applyDriver(
      applyRequestEntity.toModel(),
    );
    return remoteResponse.when(
      success: (responseModel) async {
        final localResponse = await _applyLocalDataSource.saveToken(
          responseModel.token,
        );
        return localResponse.when(
          success: (success) {
            return BaseResponse.success(responseModel.message);
          },
          failure: (exception) {
            return BaseResponse.failure(exception);
          },
        );
      },
      failure: (exception) {
        return BaseResponse<String>.failure(exception);
      },
    );
  }
}
