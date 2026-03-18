import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../core/style/color/app_colors.dart';

class UserInfoCard extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String image;
  const UserInfoCard({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 108,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.5),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 33,
            backgroundImage: CachedNetworkImageProvider(image),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(name, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 2),
                Text(email, style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 2),
                Text(phone, style: Theme.of(context).textTheme.labelLarge),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            size: 50,
            color: AppColors.inputBorder,
          ),
        ],
      ),
    );
  }
}
