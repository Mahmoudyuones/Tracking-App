import 'package:flutter/material.dart';

import '../../../../../core/style/color/app_colors.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
    required this.leading,
    required this.title,
    this.address = '',
  });

  final Widget leading;
  final String title;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            leading,
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleSmall),
                if (address.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: AppColors.lightTextSecondary,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        address,
                        style: Theme.of(context).textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
