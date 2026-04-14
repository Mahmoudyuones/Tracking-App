import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../entities/response/pending_orders_response/pending_order_response_entity.dart';
import '../repositories/pending_orders_repository.dart';

@injectable
class GetPendingOrdersUseCase {
  final PendingOrdersRepository _pendingOrdersRepository;

  GetPendingOrdersUseCase(this._pendingOrdersRepository);
  Future<BaseResponse<PendingOrderResponseEntity>> call({int limit = 10}) {
    return _pendingOrdersRepository.getPendingOrders(limit: limit);
  }
}
