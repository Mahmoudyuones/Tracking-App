import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, required this.avatarUrl});

  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 22,
      backgroundImage: avatarUrl.isNotEmpty ? NetworkImage(avatarUrl) : null,
      onBackgroundImageError: avatarUrl.isNotEmpty ? (_, _) {} : null,
      child: avatarUrl.isEmpty ? const Icon(Icons.person, size: 22) : null,
    );
  }
}
