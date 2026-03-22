import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../entities/request/apply_request_entity.dart';
import '../repositories/apply_repository.dart';

@injectable
class ApplyUseCase {
  final ApplyRepository _applyRepository;

  ApplyUseCase(this._applyRepository);

  Future<BaseResponse<String>> call(ApplyRequestEntity request) async {
    return await _applyRepository.apply(request);
  }
}
