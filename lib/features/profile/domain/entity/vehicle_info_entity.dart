import 'package:equatable/equatable.dart';
class VehicleInfoEntity extends Equatable {
  final String? vehicleType;
  final String? vehicleNumber;
  final String? vehicleLicense;

  const VehicleInfoEntity({
     this.vehicleType,
     this.vehicleNumber,
     this.vehicleLicense,
  });

  @override
  List<Object?> get props => [vehicleType, vehicleNumber, vehicleLicense];
}