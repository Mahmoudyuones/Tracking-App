import '../../../../shared/data/models/response/base_order/base_order_response_model.dart';
import '../../domain/entities/orders_entity.dart';

List<OrdersEntity> toOrdersEntityList(BaseOrderResponseModel dto) {
  final ordersModel = dto.ordersModel ?? [];
  return ordersModel.map((orders) {
    return OrdersEntity(
      storeEntity: StoreEntity(
        name: orders.store?.name ?? '',
        image: orders.store?.image ?? '',
        address: orders.store?.address ?? '',
      ),
      orderEntity: OrderEntity(
        totalPrice: orders.orderModel?.totalPrice ?? 0,
        id: orders.orderModel?.id ?? '',
        userEntity: orders.orderModel?.userModel == null
            ? const UserEntity()
            : UserEntity(
                name: orders.orderModel?.userModel?.firstName ?? '',
                image: orders.orderModel?.userModel?.photo ?? '',
                // address: orders.orderModel?.userModel?.address ?? '',
              ),
      ),
    );
  }).toList();
}
