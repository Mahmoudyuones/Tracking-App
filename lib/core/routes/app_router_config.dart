import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/profile/domain/entity/driver_all_info_entity.dart';
import '../../features/profile/domain/entity/driver_contact_info_entity.dart';
import '../../features/profile/domain/entity/driver_info_entity.dart';
import '../../features/profile/domain/entity/location_info_entity.dart';
import '../../features/profile/domain/entity/national_id_info_entity.dart';
import '../../features/profile/domain/entity/vehicle_info_entity.dart';
import '../../features/profile/presentation/views/screens/edit_vehicle_info.dart';
import '../constants/app_text_string.dart';
import 'app_routes.dart';

class AppRouterConfig {
  /// GoRouter Configuration
  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.vehicleInfoProfileRoute,
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text(AppTextString.navigationError))),
    routes: [
      /// Navigation to Boarding Screen
      GoRoute(
        path: AppRoutes.vehicleInfoProfileRoute,
        name: AppRoutes.vehicleInfoProfileRoute,
        builder: (context, state){
          final DriverAllInfoEntity user = DriverAllInfoEntity(
            location: LocationInfoEntity(country: "Egypt"),
              nid: NationalIdInfoEntity(
                nid: ""
              ),
              info: DriverInfoEntity(

              ),
              contact: DriverContactInfoEntity(
                email: "a@gmail.com",phone: "0122202"
              ),
              vehicle: VehicleInfoEntity(
            vehicleLicense: "license",vehicleNumber: "11",vehicleType: "toyota"
          ));//state.extra as DriverAllInfoEntity;
          return EditVehicleInfo(user: user);
        },
      ),
    ],
  );
}
