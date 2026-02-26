import 'dart:io';
import 'package:injectable/injectable.dart';
import '../../../../config/base_response/base_response.dart';
import '../repositories/edit_profile_repository.dart';

@injectable
class UpdateProfileImageUseCase {
  final EditProfileRepository _repository;

  UpdateProfileImageUseCase(this._repository);

  Future<BaseResponse<void>> call(File image) {
    return _repository.updateProfileImage(image);
  }
}
