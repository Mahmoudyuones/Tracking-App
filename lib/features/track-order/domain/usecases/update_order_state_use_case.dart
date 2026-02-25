import 'package:injectable/injectable.dart';

import '../../../../../../config/base_response/base_response.dart';

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
    final nextState = _getNextState(currentState);

    return await _repository.updateOrderState(
      orderId: orderId,
      state: nextState,
    );
  }

  /// Returns the next state in the order flow
  String _getNextState(String currentState) {
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
        return 'Pending';
    }
  }
}
