import '../../../../../../config/base_response/base_response.dart';
import '../../models/response/pending_order_response/pending_order_response_model.dart';

abstract interface class PendingOrdersRemoteDataSource {
  Future<BaseResponse<PendingOrderResponseModel>> getPendingOrders({int limit});
}
