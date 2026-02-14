import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class DriverContactInfoEntity extends Equatable {
  final String email;
  final String phone;

  const DriverContactInfoEntity({
    required this.email,
    required this.phone,
  });

  @override
  List<Object?> get props => [email, phone];
}