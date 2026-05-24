import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../../../../core/shared/entities/driver_details_entity.dart';
import '../repositories/sart_order_repository.dart';

@injectable
class GetDriverDetailsUseCase {
  GetDriverDetailsUseCase(this._repository);

  final StartOrderRepository _repository;

  Future<BaseResponse<DriverDetailEntity>> call() {
    return _repository.getDriverDetails();
  }
}
