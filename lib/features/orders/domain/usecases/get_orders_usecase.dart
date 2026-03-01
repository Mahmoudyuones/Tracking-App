import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../entities/orders_response_entity.dart';
import '../repos/orders_repo.dart';

@injectable
class GetOrdersUsecase {
  final OrdersRepo _repo;

  GetOrdersUsecase(this._repo);

  Future<BaseResponse<OrdersResponseEntity>> call() {
    return _repo.getOrders();
  }
}
