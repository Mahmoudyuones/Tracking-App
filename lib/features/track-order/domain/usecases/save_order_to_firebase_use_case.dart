import 'package:injectable/injectable.dart';

import '../../../../../../config/base_response/base_response.dart';
import '../../data/models/order_tracking_firebase_model.dart';
import '../../domain/repo/track_order_repo.dart';

@injectable
class SaveOrderToFirebaseUseCase {
  final TrackOrderRepo _repository;

  SaveOrderToFirebaseUseCase(this._repository);

  Future<BaseResponse<void>> call(
    OrderTrackingFirebaseModel orderTracking,
  ) async {
    return await _repository.saveOrderToFirebase(orderTracking);
  }
}
