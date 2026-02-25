import 'package:injectable/injectable.dart';

import '../../../../../../config/base_response/base_response.dart';
import '../../data/models/order_tracking_firebase_model.dart';
import '../../domain/repo/track_order_repo.dart';

@injectable
class GetOrderTrackingUseCase {
  final TrackOrderRepo _repository;

  GetOrderTrackingUseCase(this._repository);

  Future<BaseResponse<OrderTrackingFirebaseModel?>> call(String orderId) async {
    return await _repository.getOrderTracking(orderId);
  }
}
