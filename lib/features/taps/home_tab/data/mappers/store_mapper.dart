import '../../domain/entities/response/pending_orders_response/store_entity.dart';
import '../models/response/pending_order_response/store_model.dart';

extension StoreMapper on StoreModel {
  StoreEntity toEntity() {
    return StoreEntity(
      name: name,
      image: image,
      address: address,
      phoneNumber: phoneNumber,
      latLong: latLong,
    );
  }
}
