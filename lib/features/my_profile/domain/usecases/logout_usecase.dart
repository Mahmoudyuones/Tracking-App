import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../repos/my_profile_repo.dart';

@injectable
class LogoutUsecase {
  final MyProfileRepo _myProfileRepo;

  LogoutUsecase(this._myProfileRepo);

  Future<BaseResponse<void>> call() {
    return _myProfileRepo.logout();
  }
}
