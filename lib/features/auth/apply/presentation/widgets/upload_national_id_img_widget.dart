import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

import '../../../../../core/constants/app_text_string.dart';
import '../../../../../core/constants/validation_constants.dart';
import '../../../../../core/helpers/image_picker_helper.dart';
import '../../../../../core/style/color/app_colors.dart';
import '../cubit/apply_cubit.dart';
import '../cubit/apply_intents.dart';
import '../cubit/apply_state.dart';

class UploadNationalIdImgField extends StatefulWidget {
  const UploadNationalIdImgField({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;

  @override
  State<UploadNationalIdImgField> createState() =>
      _UploadNationalIdImgFieldState();
}

class _UploadNationalIdImgFieldState extends State<UploadNationalIdImgField> {
  Future<void> _pickImage(FormFieldState<File> formFieldState) async {
    final File? file = await showImagePickerDialog(context);
    if (file != null) {
      if (mounted) {
        context.read<ApplyCubit>().doIntent(
          SelectNationalIdImgIntent(nationalIdImg: file),
        );
        formFieldState.didChange(file);
        context.read<ApplyCubit>().doIntent(
          ValidateFieldsIntent(
            formsValid: widget.formKey.currentState!.validate(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return FormField<File>(
      validator: (value) {
        if (value == null) {
          return ValidationConstants.fieldRequired;
        }
        return null;
      },
      builder: (formFieldState) {
        return GestureDetector(
          onTap: () => _pickImage(formFieldState),
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: AppTextString.nationalIdLabel,
              errorText: formFieldState.errorText,
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
              suffixIcon: const Icon(
                Icons.upload_outlined,
                color: AppColors.black,
              ),
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
      },
    );
  }
}
