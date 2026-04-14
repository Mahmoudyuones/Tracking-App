import '../../domain/entities/response/pending_orders_response/meta_data_pending_order_entity.dart';
import '../models/response/pending_order_response/meta_data_pending_order_model.dart';

extension MetaDataPendingOrderMapper on MetadataPendingOrderModel {
  MetaDataPendingOrderEntity toEntity() {
    return MetaDataPendingOrderEntity(
      currentPage: currentPage,
      totalPages: totalPages,
      totalItems: totalItems,
      limit: limit,
    );
  }
}
