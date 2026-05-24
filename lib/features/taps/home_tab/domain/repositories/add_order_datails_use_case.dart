import 'package:injectable/injectable.dart';
import '../../../../../config/base_response/base_response.dart';
import '../../../../../core/shared/entities/order_details_entity.dart';
import 'sart_order_repository.dart';

@injectable
class AddOrderDatailsUseCase {
  AddOrderDatailsUseCase(this._repository);

  final StartOrderRepository _repository;

  Future<BaseResponse<void>> call({required OrderDetailsEntity orderDetails}) {
    return _repository.addOrderDetails(orderDetails: orderDetails);
  }
}
