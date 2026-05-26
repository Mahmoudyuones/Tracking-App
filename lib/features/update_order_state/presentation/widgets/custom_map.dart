import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/constants/map_constants.dart';
import '../../../../core/style/color/app_colors.dart';
import 'map_pin.dart';

class CustomMap extends StatelessWidget {
  const CustomMap({
    super.key,
    required this.centerLocation,
    required this.sourceLocation,
    required this.destinationLocation,
  });
  final LatLng centerLocation;
  final LatLng sourceLocation;
  final LatLng destinationLocation;

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
              child: const MapPin(
                color: AppColors.primary,
                icon: Icons.store_mall_directory,
                label: 'Your Location',
              ),
            ),
            Marker(
              width: 42,
              height: 42,
              point: destinationLocation,
              child: const MapPin(
                color: AppColors.primary,
                icon: Icons.home_outlined,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
