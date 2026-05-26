import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../../core/style/color/app_colors.dart';
import '../../../taps/orders_tap/order_details/presentation/views/widgets/store_avatar.dart';
import '../models/pick_up_location_args.dart';
import '../widgets/address_card_in_update_state.dart';
import '../widgets/custom_map.dart';
import '../widgets/user_avatar_in_update_state.dart';

class PickUpLocationScreen extends StatelessWidget {
  final PickUpLocationArgs args;

  const PickUpLocationScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    log(args.destinationLocation.toString());
    final address1 = AddressCardInUpdateState(
      leading: StoreAvatar(imageUrl: args.storeImageUrl),
      title: args.storeName,
      address: args.storeAddress,
      phone: args.storePhone,
    );

    final address2 = AddressCardInUpdateState(
      leading: UserAvatarInUpdateState(imageUrl: args.userImageUrl),
      title: args.userName,
      address: args.userAddress,
      phone: args.userPhone,
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
                    centerLocation: args.sourceLocation,
                    sourceLocation: args.sourceLocation,
                    destinationLocation: args.destinationLocation,
                    pickUpAddressMode: args.pickUpAddressMode,
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
                  args.pickUpAddressMode ? address1 : address2,
                  const SizedBox(height: 12),
                  args.pickUpAddressMode ? address2 : address1,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
