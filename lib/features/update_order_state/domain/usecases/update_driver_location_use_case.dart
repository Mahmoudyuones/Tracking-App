import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../../../core/shared/models/location_model.dart';
import '../repositories/update_order_state_repository.dart';

@injectable
class UpdateDriverLocationUseCase {
  final UpdateOrderStateRepository _repository;
  UpdateDriverLocationUseCase(this._repository);
  Future<BaseResponse<void>> call({
    required String orderId,
    required String userId,
    required LocationModel location,
  }) async {
    return await _repository.updateDriverLocation(
      orderId: orderId,
      userId: userId,
      location: location,
    );
  }
}
