import 'package:flutter/material.dart';

import '../../../../../features/orders/domain/entities/order_wrapper_entity.dart';
import '../widgets/order_details_app_bar.dart';
import '../widgets/order_details_body.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.order});

  final OrderWrapperEntity order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OrderDetailsAppBar(),
      body: OrderDetailsBody(order: order),
    );
  }
}
