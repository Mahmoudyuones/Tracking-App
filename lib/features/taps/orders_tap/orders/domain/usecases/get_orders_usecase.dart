import 'package:injectable/injectable.dart';

import '../../../../../../config/base_response/base_response.dart';
import '../../../../../../core/constants/app_text_string.dart';
import '../entities/orders_response_entity.dart';
import '../repos/orders_repo.dart';

@injectable
class GetOrdersUsecase {
  final OrdersRepo _repo;

  GetOrdersUsecase(this._repo);

  Future<BaseResponse<OrdersResponseEntity>> call() async {
    final result = await _repo.getOrders();

    return result.when(
      success: (response) {
        final orders = response.orders ?? [];

        final completedCount = orders
            .where(
              (wrapper) =>
                  wrapper.order?.state?.toLowerCase() ==
                  AppTextString.completed,
            )
            .length;

        final cancelledCount = orders
            .where(
              (wrapper) =>
                  wrapper.order?.state?.toLowerCase() ==
                  AppTextString.cancelled,
            )
            .length;

        return BaseResponse.success(
          OrdersResponseEntity(
            message: response.message,
            metadata: response.metadata,
            orders: response.orders,
            completedCount: completedCount,
            cancelledCount: cancelledCount,
          ),
        );
      },
      failure: (exception) => BaseResponse.failure(exception),
    );
  }
}
