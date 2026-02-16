import 'package:injectable/injectable.dart';
import '../../../../../config/base_response/base_response.dart';
import '../../data/models/request/verify_code_request_model.dart';
import '../repository/forget_password_repository.dart';

@injectable
class VerifyCodeUseCase {
  final ForgetPasswordRepository _repository;

  VerifyCodeUseCase(this._repository);
  Future<BaseResponse<void>> call(VerifyCodeRequestModel request) =>
      _repository.verifyCode(request);
}
