import '../../../../../core/constants/app_text_string.dart';
import '../../../../../core/shared/entities/driver_details_entity.dart';
import '../../../../../core/shared/entities/location_entity.dart';
import '../../../../../core/shared/entities/order_data_entity.dart' as details;
import '../../../../../core/shared/entities/order_details_entity.dart';
import '../../domain/entities/response/pending_orders_response/order_entity.dart';

extension HomeOrderDetailsMapper on OrderEntity {
  OrderDetailsEntity toOrderDetailsEntity({
    required DriverDetailEntity driver,
  }) {
    return OrderDetailsEntity(
      orders: details.OrderDataEntity(
        id: id,
        user: details.UserDataEntity(
          id: user.id,
          firstName: user.firstName,
          lastName: user.lastName,
          email: user.email,
          gender: user.gender,
          phone: user.phone,
          photo: user.photo,
          location: LocationEntity(latitude: 30.02136, longitude: 31.22686),
        ),
        orderItems: orderItems
            .map(
              (item) => details.OrderItemsEntity(
                id: item.id,
                price: item.price.toInt(),
                quantity: item.quantity,
                product: details.ProductEntity(
                  id: item.product.id,
                  title: item.product.title,
                  description: item.product.description,
                  imgCover: item.product.imageCover,
                  price: item.product.price.toInt(),
                  priceAfterDiscount: item.product.priceAfterDiscount?.toInt(),
                ),
              ),
            )
            .toList(),
        totalPrice: totalPrice.toInt(),
        paymentType: paymentType,
        isPaid: isPaid,
        isDelivered: isDelivered,
        state: state,
        orderNumber: orderNumber,
        createdAt: createdAt,
        store: details.StoreEntity(
          name: store.name,
          image: store.image,
          address: store.address,
          phoneNumber: store.phoneNumber,
          latLong: AppTextString.storeLatLong,
        ),
      ),
      driver: driver,
    );
  }
}
