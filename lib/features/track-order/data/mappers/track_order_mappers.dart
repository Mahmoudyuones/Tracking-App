import '../../domain/entities/update_order_state_request_entity.dart';
import '../models/update_order_state_request_model.dart';

extension TrackOrderMappers on UpdateOrderStateRequestEntity {
  UpdateOrderStateRequestModel toModel() {
    return UpdateOrderStateRequestModel(state: state);
  }
}
