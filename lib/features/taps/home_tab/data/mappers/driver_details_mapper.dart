import '../../../../../core/shared/models/driver_details_model.dart';
import '../../../../../core/shared/models/location_model.dart';
import '../../../profile_tab/my_profile/data/models/driver_response_model.dart';

extension DriverResponseModelMapper on DriverResponseModel {
  DriverDetailModel toDriverDetailModel() {
    final driverData = driver;

    return DriverDetailModel(
      id: driverData?.id,
      country: driverData?.country,
      firstName: driverData?.firstName,
      lastName: driverData?.lastName,
      vehicleType: driverData?.vehicleType,
      vehicleNumber: driverData?.vehicleNumber,
      vehicleLicense: driverData?.vehicleLicense,
      nID: driverData?.nid,
      nIDImg: driverData?.nidImg,
      email: driverData?.email,
      gender: driverData?.gender,
      phone: driverData?.phone,
      photo: driverData?.photo,
      createdAt: driverData?.createdAt,
      location: LocationModel(latitude: 30.0444, longitude: 31.2357),
    );
  }
}
