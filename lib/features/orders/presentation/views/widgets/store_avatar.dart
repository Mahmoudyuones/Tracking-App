import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class StoreAvatar extends StatelessWidget {
  final String imageUrl;
  const StoreAvatar({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) =>
          CircleAvatar(radius: 24, backgroundImage: imageProvider),
      errorWidget: (context, url, error) =>
          const CircleAvatar(radius: 24, child: Icon(Icons.store)),
    );
  }
}
