import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../../core/style/color/app_colors.dart';
import '../../../../../core/style/widget/loading_indicator.dart';

class StoreAvatar extends StatelessWidget {
  const StoreAvatar({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: 48,
        height: 48,
        fit: BoxFit.cover,

        placeholder: (context, url) => const LoadingIndicator(),
        errorWidget: (context, url, error) =>
            const Icon(Icons.store, color: AppColors.primary, size: 28),
      ),
    );
  }
}
