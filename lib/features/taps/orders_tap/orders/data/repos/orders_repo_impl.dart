import 'package:injectable/injectable.dart';
import '../../../../../../config/base_response/base_response.dart';
import '../../domain/entities/orders_response_entity.dart';
import '../../domain/repos/orders_repo.dart';
import '../datasources/orders_remote_data_source.dart';

@LazySingleton(as: OrdersRepo)
class OrdersRepoImpl implements OrdersRepo {
  final OrdersRemoteDataSource _remoteDataSource;

  OrdersRepoImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<OrdersResponseEntity>> getOrders() async {
    final response = await _remoteDataSource.getOrders();
    return response.when(
      success: (success) => BaseResponse.success(success.toEntity()),
      failure: (failure) => BaseResponse.failure(failure),
    );
  }
}
