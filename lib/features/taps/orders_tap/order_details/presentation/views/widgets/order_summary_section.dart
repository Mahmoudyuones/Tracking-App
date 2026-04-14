import 'package:flutter/material.dart';

import '../../../../../../../core/constants/app_text_string.dart';
import 'summary_row.dart';

class OrderSummarySection extends StatelessWidget {
  const OrderSummarySection({
    super.key,
    required this.total,
    required this.paymentMethod,
  });

  final double total;
  final String paymentMethod;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SummaryRow(
          label: AppTextString.total,
          value: '${AppTextString.egp} ${total.toInt()}',
        ),
        const Divider(height: 1, thickness: 1),
        SummaryRow(label: AppTextString.paymentMethod, value: paymentMethod),
      ],
    );
  }
}
