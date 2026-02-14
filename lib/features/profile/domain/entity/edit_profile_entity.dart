import 'package:equatable/equatable.dart';


import 'driver_contact_info_entity.dart';
import 'driver_info_entity.dart';
import 'location_info_entity.dart';
import 'national_id_info_entity.dart';
import 'vehicle_info_entity.dart';


class EditProfileEntity extends Equatable {
  final DriverInfoEntity? info;
  final DriverContactInfoEntity? contact;
  final VehicleInfoEntity? vehicle;
  final LocationInfoEntity? location;
  final NationalIdInfoEntity? nid;

  const EditProfileEntity({
     this.info,
     this.contact,
     this.vehicle,
     this.location,
     this.nid,
  });

  @override
  List<Object?> get props => [info, contact, vehicle, location, nid];
}
