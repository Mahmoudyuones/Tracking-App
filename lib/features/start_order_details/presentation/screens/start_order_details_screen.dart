import 'package:flutter/material.dart';

import '../../../taps/home_tab/domain/entities/response/start_order_response/start_order_entity.dart';

class StartOrderDetailsScreen extends StatelessWidget {
  const StartOrderDetailsScreen({super.key, required this.order});
  final StartOrderEntity order;

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Start Order Details'));
  }
}
