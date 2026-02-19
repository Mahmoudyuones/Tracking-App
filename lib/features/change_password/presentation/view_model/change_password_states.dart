import 'package:equatable/equatable.dart';

class ChangePasswordStates extends Equatable {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;
  final bool isValidForm;
  const ChangePasswordStates({
    this.isValidForm = false,
    this.currentPassword = '',
    this.newPassword = '',
    this.confirmPassword = '',
  });

  ChangePasswordStates copyWith({
    String? currentPassword,
    String? newPassword,
    String? confirmPassword,
    bool? isValidForm,
  }) {
    return ChangePasswordStates(
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isValidForm: isValidForm ?? this.isValidForm,
    );
  }

  @override
  List<Object?> get props => [
    isValidForm,
    currentPassword,
    newPassword,
    confirmPassword,
  ];
}
