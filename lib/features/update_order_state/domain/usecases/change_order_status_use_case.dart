import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../repositories/update_order_state_repository.dart';

@injectable
class ChangeOrderStatusUseCase {
  final UpdateOrderStateRepository _repository;

  ChangeOrderStatusUseCase(this._repository);

  Future<BaseResponse<void>> call({
    required String orderId,
    required String state,
  }) async {
    return await _repository.changeOrderStatus(orderId: orderId, state: state);
  }
}
