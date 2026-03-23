import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../data/models/login_request_model/login_request_model.dart';
import '../../data/models/login_response_model/login_response_model.dart';
import '../repos/login_repository.dart';

@injectable
class LoginUseCase {
  final LoginRepository _repo;

  const LoginUseCase(this._repo);

  Future<BaseResponse<LoginResponseModel>> call({
    required LoginRequestModel request,
    bool isRemembered = false,
  }) => _repo.login(request: request, remembered: isRemembered);
}
