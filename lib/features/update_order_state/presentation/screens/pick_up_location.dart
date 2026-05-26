import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/style/color/app_colors.dart';
import '../widgets/custom_map.dart';

class PickUpLocationScreen extends StatelessWidget {
  final LatLng sourceLocation;
  final LatLng destinationLocation;
  final bool pickUpAddressMode;
  final Widget address1;
  final Widget address2;

  const PickUpLocationScreen({
    super.key,
    required this.sourceLocation,
    required this.destinationLocation,
    required this.address1,
    required this.address2,
    this.pickUpAddressMode = true,
  });

  @override
  Widget build(BuildContext context) {
    final centerLocation = LatLng(
      (sourceLocation.latitude + destinationLocation.latitude) / 2,
      (sourceLocation.longitude + destinationLocation.longitude) / 2,
    );

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  CustomMap(
                    centerLocation: centerLocation,
                    sourceLocation: sourceLocation,
                    destinationLocation: destinationLocation,
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Material(
                      color: AppColors.white,
                      shape: const CircleBorder(),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () => Navigator.maybePop(context),
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.white,

                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withAlpha(20),
                    blurRadius: 16,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
                top: 4,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      Container(
                        height: 4,
                        width: 60,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 10),
                  address1,
                  const SizedBox(height: 12),
                  address2,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
