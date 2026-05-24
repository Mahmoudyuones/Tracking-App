import 'location_model.dart';

class DriverDetailModel {
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
  final LocationModel location;

  DriverDetailModel({
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
    LocationModel? location,
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
       location = location ?? LocationModel();

  factory DriverDetailModel.fromJson(Map<String, dynamic> json) {
    return DriverDetailModel(
      id: json['id'],
      country: json['country'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      vehicleType: json['vehicleType'],
      vehicleNumber: json['vehicleNumber'],
      vehicleLicense: json['vehicleLicense'],
      nID: json['nID'],
      nIDImg: json['nIDImg'],
      email: json['email'],
      gender: json['gender'],
      phone: json['phone'],
      photo: json['photo'],
      createdAt: json['createdAt'],
      location: json['location'] != null
          ? LocationModel.fromJson(json['location'])
          : LocationModel(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'country': country,
      'firstName': firstName,
      'lastName': lastName,
      'vehicleType': vehicleType,
      'vehicleNumber': vehicleNumber,
      'vehicleLicense': vehicleLicense,
      'nID': nID,
      'nIDImg': nIDImg,
      'email': email,
      'gender': gender,
      'phone': phone,
      'photo': photo,
      'createdAt': createdAt,
      'location': location.toJson(),
    };
  }
}
