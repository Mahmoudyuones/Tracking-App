import 'package:injectable/injectable.dart';
import '../../../../config/base_response/base_response.dart';
import '../../../../core/shared/entities/order_details_entity.dart';
import '../../../../core/shared/models/location_model.dart';
import '../../../taps/home_tab/data/mappers/order_details_mapper.dart';
import '../../domain/repositories/update_order_state_repository.dart';
import '../datasources/remote/update_order_state_remote_data_source.dart';

@Injectable(as: UpdateOrderStateRepository)
class UpdateOrderStateRepositoryImpl implements UpdateOrderStateRepository {
  final UpdateOrderStateRemoteDataSource _remoteDataSource;
  UpdateOrderStateRepositoryImpl(this._remoteDataSource);

  @override
  Stream<BaseResponse<OrderDetailsEntity>> getOrderByOrderId({
    required String userId,
    required String orderId,
  }) {
    return _remoteDataSource
        .getOrderByOrderId(userId: userId, orderId: orderId)
        .map(
          (response) => response.when(
            success: (model) =>
                BaseResponse<OrderDetailsEntity>.success(model.toEntity()),
            failure: (exception) =>
                BaseResponse<OrderDetailsEntity>.failure(exception),
          ),
        );
  }

  @override
  Future<BaseResponse<void>> changeOrderStatus({
    required String orderId,
    required String state,
  }) {
    return _remoteDataSource.changeOrderStatus(orderId: orderId, state: state);
  }

  @override
  Future<BaseResponse<void>> updateOrderStatusInFirestore({
    required String userId,
    required String orderId,
    required String status,
  }) {
    return _remoteDataSource.updateOrderStatusInFirestore(
      userId: userId,
      orderId: orderId,
      status: status,
    );
  }

  @override
  Future<BaseResponse<void>> updateDriverLocation({required String orderId, required String userId, required LocationModel location}) {
    return _remoteDataSource.updateLocation(orderId: orderId, userId: userId, location: location);
  }
}
