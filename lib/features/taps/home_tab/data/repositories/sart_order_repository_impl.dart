import 'package:injectable/injectable.dart';
import '../../../../../config/base_response/base_response.dart';
import '../../../../../core/shared/entities/order_details_entity.dart';
import '../../domain/entities/response/start_order_response/start_order_response_entity.dart';
import '../../domain/repositories/sart_order_repository.dart';
import '../datasources/remote/start_order_remote_data_source.dart';
import '../mappers/order_details_mapper.dart';
import '../mappers/start_order_mappers/start_order_response_mapper.dart';

@Injectable(as: StartOrderRepository)
class SartOrderRepositoryImpl implements StartOrderRepository {
  final StartOrderRemoteDataSource remoteDataSource;

  SartOrderRepositoryImpl({required this.remoteDataSource});

  @override
  Future<BaseResponse<StartOrderResponseEntity>> startOrder(
    String orderId,
  ) async {
    final response = await remoteDataSource.startOrder(orderId);
    return response.when(
      success: (data) {
        return BaseResponse.success(data.toEntity());
      },
      failure: (failure) {
        return BaseResponse.failure(failure);
      },
    );
  }

  @override
  Future<BaseResponse<void>> addOrderDetails({
    required OrderDetailsEntity orderDetails,
  }) {
    return remoteDataSource.addOrderDetails(
      orderDetails: orderDetails.toModel(),
    );
  }
}
