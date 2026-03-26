import 'package:flutter/material.dart';

import '../../../../../core/style/color/app_colors.dart';

class StoreAvatar extends StatelessWidget {
  const StoreAvatar({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          imageUrl,
          width: 44,
          height: 44,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => _placeholder(),
        ),
      );
    }
    return _placeholder();
  }

  Widget _placeholder() => Container(
    width: 44,
    height: 44,
    decoration: BoxDecoration(
      color: AppColors.primary.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: const Icon(Icons.shop_2, color: AppColors.primary, size: 22),
  );
}
