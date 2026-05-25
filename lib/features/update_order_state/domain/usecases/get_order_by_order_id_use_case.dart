import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../../../core/shared/entities/order_details_entity.dart';
import '../repositories/update_order_state_repository.dart';

@injectable
class GetOrderByOrderidUseCase {
  final UpdateOrderStateRepository _repository;

  GetOrderByOrderidUseCase(this._repository);

  Stream<BaseResponse<OrderDetailsEntity>> call({
    required String userId,
    required String orderId,
  }) {
    return _repository.getOrderByOrderId(userId: userId, orderId: orderId);
  }
}
