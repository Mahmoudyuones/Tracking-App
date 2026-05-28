import 'package:latlong2/latlong.dart';

import '../cubit/update_order_state_cubit.dart';

class PickUpLocationArgs {
  final String storeImageUrl;
  final String storeName;
  final String storeAddress;
  final String storePhone;
  final String userImageUrl;
  final String userName;
  final String userAddress;
  final String userPhone;
  final LatLng sourceLocation;
  final LatLng destinationLocation;
  final bool pickUpAddressMode;
  final UpdateOrderStateCubit cubit;

  const PickUpLocationArgs({
    required this.storeImageUrl,
    required this.storeName,
    required this.storeAddress,
    required this.storePhone,
    required this.userImageUrl,
    required this.userName,
    required this.userAddress,
    required this.userPhone,
    required this.sourceLocation,
    required this.destinationLocation,
    required this.cubit,
    this.pickUpAddressMode = true,
  });
}
