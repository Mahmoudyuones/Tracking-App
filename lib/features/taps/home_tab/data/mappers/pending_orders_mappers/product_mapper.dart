import '../../../domain/entities/response/pending_orders_response/product_entity.dart';
import '../../models/response/pending_order_response/product_model.dart';

extension ProductMapper on ProductModel {
  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      title: title,
      description: description,
      imageCover: imgCover,
      price: price.toDouble(),
      priceAfterDiscount: priceAfterDiscount.toDouble(),
    );
  }
}
