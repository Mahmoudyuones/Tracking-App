import '../../domain/entities/change_password_request_entity.dart';
import '../models/change_password_request_model.dart';

extension ChangePasswordRequestMapper on ChangePasswordRequestEntity {
  ChangePasswordRequestModel toModel() {
    return ChangePasswordRequestModel(
      password: password,
      newPassword: newPassword,
    );
  }
}
