import 'package:injectable/injectable.dart';
import '../../../../config/base_response/base_response.dart';
import '../repositories/update_order_state_repository.dart';

@injectable
class UpdateOrderStatusInFirestoreUseCase {
  final UpdateOrderStateRepository _repository;

  UpdateOrderStatusInFirestoreUseCase(this._repository);

  Future<BaseResponse<void>> call({
    required String userId,
    required String orderId,
    required String newStatus,
  }) {
    return _repository.updateOrderStatusInFirestore(
      userId: userId,
      orderId: orderId,
      status: newStatus,
    );
  }
}
