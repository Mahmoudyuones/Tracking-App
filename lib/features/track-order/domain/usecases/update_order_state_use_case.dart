import 'package:injectable/injectable.dart';

import '../../../../../../config/base_response/base_response.dart';
import '../../domain/entities/update_order_state_request_entity.dart';
import '../../domain/repo/track_order_repo.dart';

@injectable
class UpdateOrderStateUseCase {
  final TrackOrderRepo _repository;

  UpdateOrderStateUseCase(this._repository);

  Future<BaseResponse<void>> call({
    required String orderId,
    required String currentState,
  }) async {
    // Get the next state based on current state
    final firebaseNextState = _getFirebaseNextState(currentState);
    final apiNextState = _getApiNextState(currentState);

    return await _repository.updateOrderState(
      orderId,
      firebaseNextState,
      UpdateOrderStateRequestEntity(state: apiNextState),
    );
  }

  /// Returns the next Firebase state for UI tracking
  String _getFirebaseNextState(String currentState) {
    switch (currentState.toLowerCase()) {
      case 'pending':
        return 'Accepted';
      case 'accepted':
        return 'Picked';
      case 'picked':
        return 'Out for delivery';
      case 'out for delivery':
        return 'Arrived';
      case 'arrived':
        return 'Delivered';
      default:
        return 'pending'; // Changed from 'Pending' to match lowercase pattern
    }
  }

  /// Returns the API state (inProgress or completed)
  String _getApiNextState(String currentState) {
    switch (currentState.toLowerCase()) {
      case 'pending':
      case 'accepted':
      case 'picked':
      case 'out for delivery':
        return 'inProgress';
      case 'arrived':
        return 'completed';
      default:
        return 'pending'; // Changed from 'Pending' to match API states
    }
  }
}
