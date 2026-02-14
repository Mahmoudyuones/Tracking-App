
import 'driver_contact_info_entity.dart';
import 'driver_info_entity.dart';
import 'location_info_entity.dart';
import 'national_id_info_entity.dart';
import 'vehicle_info_entity.dart';

class DriverAllInfoEntity {
  final DriverInfoEntity? info;
  final DriverContactInfoEntity? contact;
  final VehicleInfoEntity? vehicle;
  final LocationInfoEntity? location;
  final NationalIdInfoEntity? nid;

  const DriverAllInfoEntity({
    this.info,
    this.contact,
    this.vehicle,
    this.location,
    this.nid,
  });
}
