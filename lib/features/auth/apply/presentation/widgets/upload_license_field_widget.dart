import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

import '../../../../../core/constants/app_text_string.dart';
import '../../../../../core/helpers/image_picker_helper.dart';
import '../../../../../core/style/color/app_colors.dart';
import '../cubit/apply_cubit.dart';
import '../cubit/apply_intents.dart';
import '../cubit/apply_state.dart';

class UploadLicenseField extends StatefulWidget {
  const UploadLicenseField({super.key});

  @override
  State<UploadLicenseField> createState() => _UploadLicenseFieldState();
}

class _UploadLicenseFieldState extends State<UploadLicenseField> {
  Future<void> _pickImage() async {
    final File? file = await showImagePickerDialog(context);
    if (file != null) {
      if (mounted) {
        context.read<ApplyCubit>().doIntent(
          SelectVehicleLicenseIntent(vehicleLicense: file),
        );
        context.read<ApplyCubit>().doIntent(
          ValidateFieldsIntent(vehicleLicense: file),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: _pickImage,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: AppTextString.vehicleLicenseLabel,
          labelStyle: const TextStyle(
            color: AppColors.lightTextSecondary,
            fontSize: 14,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: AppColors.inputBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(
              color: AppColors.inputBorder,
              width: 2,
            ),
          ),
          suffixIcon: const Icon(Icons.upload_outlined, color: AppColors.black),
        ),
        child: BlocBuilder<ApplyCubit, ApplyState>(
          buildWhen: (previous, current) =>
              previous.vehicleLicense != current.vehicleLicense,
          builder: (context, state) {
            return Text(
              state.vehicleLicense != null
                  ? state.vehicleLicense!.path.split('/').last
                  : AppTextString.uploadLicensePhoto,
              style: textTheme.bodyMedium?.copyWith(
                color: state.vehicleLicense != null
                    ? AppColors.black
                    : AppColors.gray,
              ),
            );
          },
        ),
      ),
    );
  }
}
