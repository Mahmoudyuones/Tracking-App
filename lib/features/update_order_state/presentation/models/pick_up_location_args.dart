import 'package:latlong2/latlong.dart';

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
    this.pickUpAddressMode = true,
  });
}
