import '../../../domain/entities/response/start_order_response/start_order_response_entity.dart';
import '../../models/response/start_order_response/start_order_response_model.dart';
import 'start_order_mapper.dart';

extension StartOrderResponseMapper on StartOrderResponseModel {
  StartOrderResponseEntity toEntity() {
    return StartOrderResponseEntity(message: message, order: order.toEntity());
  }
}
