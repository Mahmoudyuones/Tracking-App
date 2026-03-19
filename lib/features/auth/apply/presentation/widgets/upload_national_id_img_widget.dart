import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

import '../../../../../core/constants/app_text_string.dart';
import '../../../../../core/helpers/image_picker_helper.dart';
import '../../../../../core/style/color/app_colors.dart';
import '../cubit/apply_cubit.dart';
import '../cubit/apply_intents.dart';
import '../cubit/apply_state.dart';

class UploadNationalIdImgField extends StatefulWidget {
  const UploadNationalIdImgField({super.key});

  @override
  State<UploadNationalIdImgField> createState() =>
      _UploadNationalIdImgFieldState();
}

class _UploadNationalIdImgFieldState extends State<UploadNationalIdImgField> {
  Future<void> _pickImage() async {
    final File? file = await showImagePickerDialog(context);
    if (file != null) {
      if (mounted) {
        context.read<ApplyCubit>().doIntent(
          SelectNationalIdImgIntent(nationalIdImg: file),
        );
        context.read<ApplyCubit>().doIntent(
          ValidateFieldsIntent(nationalIdImg: file),
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
          labelText: AppTextString.nationalIdLabel,
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
              previous.nationalIdImg != current.nationalIdImg,
          builder: (context, state) {
            return Text(
              state.nationalIdImg != null
                  ? state.nationalIdImg!.path.split('/').last
                  : AppTextString.uploadNationalIdPhoto,
              style: textTheme.bodyMedium?.copyWith(
                color: state.nationalIdImg != null
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
