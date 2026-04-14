import 'package:injectable/injectable.dart';
import '../../../../../../config/base_response/base_response.dart';
import '../../data/models/request/edit_profile_request.dart';
import '../repositories/edit_profile_repository.dart';

@injectable
class EditProfileUseCase {
  final EditProfileRepository _repository;

  EditProfileUseCase(this._repository);

  Future<BaseResponse<void>> call(EditProfileRequest request) {
    return _repository.editProfile(request);
  }
}
