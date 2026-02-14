import 'package:equatable/equatable.dart';
class DriverInfoEntity extends Equatable {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? photo;
  final String? role;

  const DriverInfoEntity({
     this.id,
     this.firstName,
     this.lastName,
     this.gender,
     this.photo,
     this.role,
  });

  @override
  List<Object?> get props => [id, firstName, lastName, gender, photo, role];
}