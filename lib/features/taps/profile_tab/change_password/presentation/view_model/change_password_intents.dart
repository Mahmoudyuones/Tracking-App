import '../../domain/entities/change_password_request_entity.dart';

sealed class ChangePasswordIntents {
  const ChangePasswordIntents();
}

class UpdatePasswordSubmitIntent extends ChangePasswordIntents {
  final ChangePasswordRequestEntity changePasswordRequestEntity;

  UpdatePasswordSubmitIntent({required this.changePasswordRequestEntity});
}

class ValidateFields extends ChangePasswordIntents {
  final String password;
  final String newPassword;
  final String confirmPassword;

  ValidateFields({
    required this.password,
    required this.newPassword,
    required this.confirmPassword,
  });
}
