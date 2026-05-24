import 'package:injectable/injectable.dart';
import '../../../../../config/base_response/base_response.dart';
import '../../../../../core/shared/entities/driver_details_entity.dart';
import '../../../../../core/shared/entities/order_details_entity.dart';
import '../../../profile_tab/my_profile/data/datasources/my_profile_remote_data_source.dart';
import '../../domain/entities/response/start_order_response/start_order_response_entity.dart';
import '../../domain/repositories/sart_order_repository.dart';
import '../datasources/remote/start_order_remote_data_source.dart';
import '../mappers/driver_details_mapper.dart';
import '../mappers/order_details_mapper.dart';
import '../mappers/start_order_mappers/start_order_response_mapper.dart';

@Injectable(as: StartOrderRepository)
class SartOrderRepositoryImpl implements StartOrderRepository {
  final StartOrderRemoteDataSource remoteDataSource;
  final MyProfileRemoteDataSource myProfileRemoteDataSource;

  SartOrderRepositoryImpl({
    required this.remoteDataSource,
    required this.myProfileRemoteDataSource,
  });

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

  @override
  Future<BaseResponse<DriverDetailEntity>> getDriverDetails() async {
    final response = await myProfileRemoteDataSource.getMyProfileData();
    return response.when(
      success: (success) {
        final driverDetailsModel = success.toDriverDetailModel();
        return BaseResponse.success((driverDetailsModel.toEntity()));
      },
      failure: (failure) => BaseResponse.failure(failure),
    );
  }
}
