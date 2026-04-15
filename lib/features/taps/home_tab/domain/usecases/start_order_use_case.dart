import 'package:injectable/injectable.dart';
import '../../../../../config/base_response/base_response.dart';
import '../entities/response/start_order_response/start_order_response_entity.dart';
import '../repositories/sart_order_repository.dart';

@injectable
class StartOrderUseCase {
  final StartOrderRepository repository;

  StartOrderUseCase({required this.repository});

  Future<BaseResponse<StartOrderResponseEntity>> call(String orderId) async {
    return await repository.startOrder(orderId);
  }
}
