import '../../../domain/entities/request/apply_request_entity.dart';
import '../../models/request/apply_request_model/apply_request_model.dart';

extension ApplyRequestMapper on ApplyRequestEntity {
  ApplyRequestModel toModel() {
    return ApplyRequestModel(
      country: country,
      firstName: firstName,
      lastName: lastName,
      vehicleType: vehicleType,
      vehicleNumber: vehicleNumber,
      vehicleLicense: vehicleLicense,
      nID: nID,
      nIDImg: nIDImg,
      email: email,
      password: password,
      rePassword: rePassword,
      gender: gender,
      phone: phone,
    );
  }
}
