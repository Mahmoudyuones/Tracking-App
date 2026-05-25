import 'package:flutter/material.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/constants/app_text_string.dart';
import '../../../../core/shared/entities/order_details_entity.dart';
import '../../../../core/style/color/app_colors.dart';
import '../../../taps/orders_tap/order_details/presentation/views/widgets/store_avatar.dart';
import 'address_card_in_update_state.dart';
import 'order_state_header.dart';
import 'order_state_item_card.dart';
import 'custom_stepper.dart';
import 'total_and_payment_sections.dart';
import 'user_avatar_in_update_state.dart';

class OrderStateDetailsBody extends StatelessWidget {
  const OrderStateDetailsBody({
    super.key,
    required this.orderDetails,
    required this.isUpdating,
    required this.onUpdateStatus,
  });

  final OrderDetailsEntity orderDetails;
  final bool isUpdating;
  final void Function(String newStatus) onUpdateStatus;

  static const _statusFlow = [
    'pending',
    'accepted',
    'picked',
    'out for delivery',
    'delivered',
  ];

  String _pickNextStatus(String currentState) {
    final index = _statusFlow.indexOf(currentState.toLowerCase());
    if (index == -1 || index == _statusFlow.length - 1) return '';
    return _statusFlow[index + 1];
  }

  String _statusButtonLabel(String currentState) {
    switch (currentState.toLowerCase()) {
      case 'pending':
      case 'accepted':
        return AppTextString.arrivedAtPickupPoint;
      case 'picked':
        return AppTextString.startDeliver;
      case 'out for delivery':
        return AppTextString.arrivedToUser;
      default:
        return AppTextString.updateStatus;
    }
  }

  @override
  Widget build(BuildContext context) {
    final order = orderDetails.orders;
    final store = order.store;
    final user = order.user;
    final items = order.orderItems;
    final currentStatus = order.state.isEmpty ? 'pending' : order.state;
    final nextStatus = _pickNextStatus(currentStatus);
    final orderId = order.orderNumber.isNotEmpty ? order.orderNumber : order.id;
    final orderDate = order.createdAt.isNotEmpty
        ? order.createdAt
        : AppTextString.orderDateUnknown;
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomStepper(currentStep: 0),
          const SizedBox(height: 24),
          OrderStateHeader(
            statusLabel: currentStatus,
            orderId: orderId,
            orderDate: orderDate,
          ),
          const SizedBox(height: 16),
          Text(
            AppTextString.pickupAddress,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          AddressCardInUpdateState(
            leading: StoreAvatar(imageUrl: store.image),
            title: store.name,
            address: store.address,
            phone: store.phoneNumber,
          ),
          const SizedBox(height: 16),
          Text(
            AppTextString.userAddress,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          AddressCardInUpdateState(
            leading: UserAvatarInUpdateState(
              imageUrl: '${ApiEndpoints.basePhoto}${user.photo}',
            ),
            title: '${user.firstName} ${user.lastName}'.trim(),
            address: AppTextString.defaultDeliveryAddress,
            phone: user.phone,
          ),
          const SizedBox(height: 16),
          Text(
            AppTextString.orderDetails,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
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
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: nextStatus.isEmpty || isUpdating
                  ? null
                  : () => onUpdateStatus(nextStatus),
              style: ElevatedButton.styleFrom(
                backgroundColor: nextStatus.isEmpty
                    ? AppColors.lightTextSecondary
                    : null,
              ),
              child: isUpdating
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(
                      _statusButtonLabel(currentStatus),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
