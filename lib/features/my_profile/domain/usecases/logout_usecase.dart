import '../../../../config/base_response/base_response.dart';
import '../repos/my_profile_repo.dart';

class LogoutUsecase {
  final MyProfileRepo _myProfileRepo;

  LogoutUsecase(this._myProfileRepo);

  Future<BaseResponse<void>> call() async {
    return await _myProfileRepo.logout();
  }
}
