import 'package:injectable/injectable.dart';
import '../../../../../config/base_response/base_response.dart';
import '../../data/models/request/forget_password_request_model.dart';
import '../repository/forget_password_repository.dart';

@injectable
class ForgetPasswordUseCase {
  final ForgetPasswordRepository _repository;

  ForgetPasswordUseCase(this._repository);
  Future<BaseResponse<void>> call(ForgetPasswordRequestModel request) =>
      _repository.forgetPassword(request);
}
