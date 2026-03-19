import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../constants/app_text_string.dart';
import '../style/color/app_colors.dart';

Future<File?> showImagePickerDialog(BuildContext context) async {
  final ImagePicker picker = ImagePicker();
  File? selectedFile;

  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        AppTextString.uploadPhoto,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
      backgroundColor: AppColors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: AppColors.white,
              child: Icon(Icons.photo_library, color: AppColors.primary),
            ),
            title: Text(
              AppTextString.gallery,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            subtitle: Text(
              AppTextString.chooseFromYourPhotos,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            onTap: () async {
              final XFile? image = await picker.pickImage(
                source: ImageSource.gallery,
              );
              if (image != null) {
                selectedFile = File(image.path);
              }
              if (context.mounted) Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: AppColors.white,
              child: Icon(Icons.camera_alt, color: AppColors.primary),
            ),
            title: Text(
              AppTextString.camera,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            subtitle: Text(
              AppTextString.takeNewPhoto,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            onTap: () async {
              final XFile? image = await picker.pickImage(
                source: ImageSource.camera,
              );
              if (image != null) {
                selectedFile = File(image.path);
              }
              if (context.mounted) Navigator.pop(context);
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            AppTextString.cancel,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );

  return selectedFile;
}
