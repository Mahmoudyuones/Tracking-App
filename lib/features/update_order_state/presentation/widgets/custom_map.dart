import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/constants/app_text_string.dart';
import '../../../../core/constants/map_constants.dart';
import '../../../../core/style/color/app_colors.dart';
import 'map_pin.dart';

class CustomMap extends StatelessWidget {
  const CustomMap({
    super.key,
    required this.centerLocation,
    required this.sourceLocation,
    required this.destinationLocation,
    this.pickUpAddressMode = true,
  });
  final LatLng centerLocation;
  final LatLng sourceLocation;
  final LatLng destinationLocation;
  final bool pickUpAddressMode;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: centerLocation,
        initialZoom: 13.2,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all,
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: MapConstants.urlTemplate,
          userAgentPackageName: MapConstants.userAgentPackageName,
        ),
        PolylineLayer(
          polylines: [
            Polyline(
              points: [sourceLocation, destinationLocation],
              strokeWidth: 5.0,
              color: AppColors.primary,
              borderStrokeWidth: 1.2,
              borderColor: AppColors.white,
            ),
          ],
        ),
        MarkerLayer(
          markers: [
            Marker(
              width: 160,
              height: 70,
              point: sourceLocation,
              child: MapPin(
                color: AppColors.primary,
                icon: Icons.location_on_outlined,
                label: AppTextString.yourLocation,
                pinColor: AppColors.blue,
                secondPinColor: AppColors.white,
              ),
            ),
            Marker(
              width: 160,
              height: 70,
              point: destinationLocation,
              child: MapPin(
                color: AppColors.primary,
                icon: pickUpAddressMode
                    ? Icons.store_mall_directory
                    : Icons.home_outlined,
                label: pickUpAddressMode
                    ? AppTextString.flowery
                    : AppTextString.user,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
