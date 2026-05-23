import 'location_entity.dart';

class DriverDetailEntity {
  final String id;
  final String country;
  final String firstName;
  final String lastName;
  final String vehicleType;
  final String vehicleNumber;
  final String vehicleLicense;
  final String nID;
  final String nIDImg;
  final String email;
  final String gender;
  final String phone;
  final String photo;
  final String createdAt;
  final LocationEntity location;

  DriverDetailEntity({
    String? id,
    String? country,
    String? firstName,
    String? lastName,
    String? vehicleType,
    String? vehicleNumber,
    String? vehicleLicense,
    String? nID,
    String? nIDImg,
    String? email,
    String? gender,
    String? phone,
    String? photo,
    String? createdAt,
    LocationEntity? location,
  }) : id = id ?? '',
       country = country ?? '',
       firstName = firstName ?? '',
       lastName = lastName ?? '',
       vehicleType = vehicleType ?? '',
       vehicleNumber = vehicleNumber ?? '',
       vehicleLicense = vehicleLicense ?? '',
       nID = nID ?? '',
       nIDImg = nIDImg ?? '',
       email = email ?? '',
       gender = gender ?? '',
       phone = phone ?? '',
       photo = photo ?? '',
       createdAt = createdAt ?? '',
       location = location ?? LocationEntity();
}
