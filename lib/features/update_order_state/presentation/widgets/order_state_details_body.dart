import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/constants/app_text_string.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/shared/entities/order_details_entity.dart';
import '../../../taps/orders_tap/order_details/presentation/views/widgets/store_avatar.dart';
import '../cubit/update_order_state_cubit.dart';
import '../cubit/update_order_state_state.dart';
import '../models/pick_up_location_args.dart';
import 'address_card_in_update_state.dart';
import 'order_state_header.dart';
import 'order_state_item_card.dart';
import 'custom_stepper.dart';
import 'total_and_payment_sections.dart';
import 'updated_button.dart';
import 'user_avatar_in_update_state.dart';

class OrderStateDetailsBody extends StatelessWidget {
  const OrderStateDetailsBody({super.key, required this.orderDetails});

  final OrderDetailsEntity orderDetails;

  @override
  Widget build(BuildContext context) {
    final order = orderDetails.orders;
    final store = order.store;
    final user = order.user;
    final items = order.orderItems;
    final driver = orderDetails.driver;
    final currentStatus = order.state;
    final orderId = order.orderNumber.isNotEmpty ? order.orderNumber : order.id;
    final orderDate = order.createdAt.isNotEmpty
        ? order.createdAt
        : AppTextString.orderDateUnknown;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<UpdateOrderStateCubit, UpdateOrderStateState>(
                  buildWhen: (previous, current) =>
                      previous.currentStep != current.currentStep,
                  builder: (context, state) {
                    return CustomStepper(currentStep: state.currentStep);
                  },
                ),
                const SizedBox(height: 24),
                OrderStateHeader(
                  statusLabel: currentStatus,
                  orderId: orderId,
                  orderDate: orderDate,
                ),
                const SizedBox(height: 16),
                Text(
                  AppTextString.pickupAddress,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    final parts = store.latLong.split(',');
                    final destinationLocation = LatLng(
                      double.parse(parts[0]),
                      double.parse(parts[1]),
                    );
                    final driverLocation = LatLng(
                      driver.location.latitude,
                      driver.location.longitude,
                    );
                    context.pushNamed(
                      AppRoutes.pickUpLocation,
                      extra: PickUpLocationArgs(
                        storeImageUrl: store.image,
                        storeName: store.name,
                        storeAddress: store.address,
                        storePhone: store.phoneNumber,
                        userImageUrl: '${ApiEndpoints.basePhoto}${user.photo}',
                        userName: '${user.firstName} ${user.lastName}'.trim(),
                        userAddress: AppTextString.defaultDeliveryAddress,
                        userPhone: user.phone,
                        destinationLocation: destinationLocation,
                        sourceLocation: driverLocation,
                      ),
                    );
                  },
                  child: AddressCardInUpdateState(
                    leading: StoreAvatar(imageUrl: store.image),
                    title: store.name,
                    address: store.address,
                    phone: store.phoneNumber,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  AppTextString.userAddress,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    final destinationLocation = LatLng(
                      order.user.location.latitude,
                      order.user.location.longitude,
                    );
                    final driverLocation = LatLng(
                      driver.location.latitude,
                      driver.location.longitude,
                    );
                    context.pushNamed(
                      AppRoutes.pickUpLocation,
                      extra: PickUpLocationArgs(
                        storeImageUrl: store.image,
                        storeName: store.name,
                        storeAddress: store.address,
                        storePhone: store.phoneNumber,
                        userImageUrl: '${ApiEndpoints.basePhoto}${user.photo}',
                        userName: '${user.firstName} ${user.lastName}'.trim(),
                        userAddress: AppTextString.defaultDeliveryAddress,
                        userPhone: user.phone,
                        destinationLocation: destinationLocation,
                        sourceLocation: driverLocation,
                        pickUpAddressMode: false,
                      ),
                    );
                  },
                  child: AddressCardInUpdateState(
                    leading: UserAvatarInUpdateState(
                      imageUrl: '${ApiEndpoints.basePhoto}${user.photo}',
                    ),
                    title: '${user.firstName} ${user.lastName}'.trim(),
                    address: AppTextString.defaultDeliveryAddress,
                    phone: user.phone,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  AppTextString.orderDetails,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                if (items.isEmpty)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        AppTextString.noItemsFound,
                        style: textTheme.bodyMedium,
                      ),
                    ),
                  )
                else
                  Column(
                    children: items.map((item) {
                      return OrderStateItemCard(item: item);
                    }).toList(),
                  ),
                const SizedBox(height: 4),
                TotalAndPaymentSections(
                  paymentType: order.paymentType,
                  totalPrice: order.totalPrice.toString(),
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 14),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: UpdatedButton(orderId: order.id, userId: user.id),
        ),
      ],
    );
  }
}
