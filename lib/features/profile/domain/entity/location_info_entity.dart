import 'package:equatable/equatable.dart';
class LocationInfoEntity extends Equatable {
  final String? country;
  final String? createdAt;

  const LocationInfoEntity({
     this.country,
     this.createdAt,
  });

  @override
  List<Object?> get props => [country, createdAt];
}
