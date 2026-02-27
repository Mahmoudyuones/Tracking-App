import 'package:flutter/material.dart';
import '../../../../../core/constants/app_text_string.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).maybePop(),
            child: Text(
              AppTextString.profileNav,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Icon(
            Icons.notifications_outlined,
            size: 26,
            color: Theme.of(context).appBarTheme.iconTheme?.color,
          ),
        ],
      ),
    );
  }
}
