import '../../../../../config/base_response/base_response.dart';
import '../../../../../core/shared/entities/driver_details_entity.dart';
import '../../../../../core/shared/entities/order_details_entity.dart';
import '../entities/response/start_order_response/start_order_response_entity.dart';

abstract interface class StartOrderRepository {
  Future<BaseResponse<StartOrderResponseEntity>> startOrder(String orderId);
  Future<BaseResponse<void>> addOrderDetails({
    required OrderDetailsEntity orderDetails,
  });
  Future<BaseResponse<DriverDetailEntity>> getDriverDetails();
}
