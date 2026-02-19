import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../data/models/request/reset_password_request_model.dart';
import '../repository/forget_password_repository.dart';

@injectable
class ResetPasswordUseCase {
  final ForgetPasswordRepository _repository;

  ResetPasswordUseCase(this._repository);
  Future<BaseResponse<void>> call(ResetPasswordRequestModel request) =>
      _repository.resetCode(request);
}
