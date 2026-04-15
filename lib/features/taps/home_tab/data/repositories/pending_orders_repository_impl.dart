import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../domain/entities/response/pending_orders_response/pending_order_response_entity.dart';
import '../../domain/repositories/pending_orders_repository.dart';
import '../datasources/remote/pending_orders_remote_data_source.dart';
import '../mappers/pending_order_response_mapper.dart';

@LazySingleton(as: PendingOrdersRepository)
class PendingOrdersRepositoryImpl implements PendingOrdersRepository {
  final PendingOrdersRemoteDataSource _pendingOrdersRemoteDataSource;

  PendingOrdersRepositoryImpl(this._pendingOrdersRemoteDataSource);

  @override
  Future<BaseResponse<PendingOrderResponseEntity>> getPendingOrders({
    int? limit,
    required int page,
  }) async {
    final response = await _pendingOrdersRemoteDataSource.getPendingOrders(
      limit: limit,
      page: page,
    );
    return response.when(
      success: (pendingOrderResponseModel) {
        return BaseResponse<PendingOrderResponseEntity>.success(
          pendingOrderResponseModel.toEntity(),
        );
      },
      failure: (failure) {
        return BaseResponse<PendingOrderResponseEntity>.failure(failure);
      },
    );
  }
}
