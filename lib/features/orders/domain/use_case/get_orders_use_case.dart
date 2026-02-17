import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../entities/orders_entity.dart';
import '../repos/order_repo.dart';

@injectable
class GetOrdersUseCase {
  final OrderRepo _orderRepo;

  GetOrdersUseCase(this._orderRepo);

  Future<BaseResponse<List<OrdersEntity>>> call() => _orderRepo.getOrders();
}
