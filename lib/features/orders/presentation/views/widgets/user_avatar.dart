import 'package:flutter/material.dart';

import '../../../../../core/style/color/app_colors.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, required this.avatarUrl});

  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 22,
      backgroundColor: AppColors.lightTextSecondary,
      child: Icon(Icons.person, size: 36, color: AppColors.white),
    );
  }
}
