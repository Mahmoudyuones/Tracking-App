import 'package:injectable/injectable.dart';
import '../../../../config/base_response/base_response.dart';
import '../entities/driver_response_entity.dart';
import '../repos/my_profile_repo.dart';

@injectable
class GetDriverProfileDateUsecase {
  final MyProfileRepo _myProfileRepo;

  GetDriverProfileDateUsecase(this._myProfileRepo);

  Future<BaseResponse<DriverResponseEntity>> call() {
    return _myProfileRepo.getMyProfileData();
  }
}
