import 'package:equatable/equatable.dart';

class ChangePasswordRequestEntity extends Equatable {
  final String password;
  final String newPassword;

  const ChangePasswordRequestEntity({
    required this.password,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [password, newPassword];
}
