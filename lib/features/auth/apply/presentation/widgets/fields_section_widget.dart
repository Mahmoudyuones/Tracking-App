import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_text_string.dart';
import '../../../../../core/extention/spacing.dart';
import '../../../../../core/style/color/app_colors.dart';
import '../../../../../core/validators/app_validators.dart';
import '../../domain/entities/request/vehicle_types_entity.dart';
import '../cubit/apply_cubit.dart';
import '../cubit/apply_intents.dart';
import 'gender_section_widget.dart';
import 'name_fields_widget.dart';
import 'password_flields_widget.dart';
import 'upload_license_field_widget.dart';
import 'upload_national_id_img_widget.dart';

class FieldsSectionWidget extends StatefulWidget {
  const FieldsSectionWidget({
    super.key,
    required this.firstNameController,
    required this.secondNameController,
    required this.vehicleTypeController,
    required this.vehicleNumberController,
    required this.emailController,
    required this.phoneNumberController,
    required this.nationalIdController,
    required this.passwordController,
    required this.confirmPasswordController,
  });
  final TextEditingController firstNameController;
  final TextEditingController secondNameController;
  final String? vehicleTypeController;
  final TextEditingController vehicleNumberController;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final TextEditingController nationalIdController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  State<FieldsSectionWidget> createState() => _FieldsSectionWidgetState();
}

class _FieldsSectionWidgetState extends State<FieldsSectionWidget> {
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(
      context,
    ).textTheme.bodyLarge?.copyWith(fontWeight: .w500, color: AppColors.black);
    return Column(
      children: [
        NameFieldsWidget(
          firstNameController: widget.firstNameController,
          secondNameController: widget.secondNameController,
        ),
        24.verticalSpacing,
        DropdownButtonFormField<String>(
          dropdownColor: AppColors.whiteLight,
          items: VehicleTypeEntity.vehicleTypes.map((vehicle) {
            return DropdownMenuItem<String>(
              value: vehicle.id,
              child: Text(vehicle.type),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              context.read<ApplyCubit>().doIntent(
                SelectVehicleTypeIntent(vehicleType: value),
              );
            }
            context.read<ApplyCubit>().doIntent(
              ValidateFieldsIntent(vehicleType: value),
            );
          },
          validator: AppValidators.validateRequired,
          decoration: InputDecoration(
            labelText: AppTextString.vehicleTypeLabel,
          ),
        ),
        24.verticalSpacing,
        TextFormField(
          controller: widget.vehicleNumberController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: AppTextString.vehicleNumberLabel,
          ),
          style: textStyle,
          validator: AppValidators.validateRequired,
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          onChanged: (value) {
            context.read<ApplyCubit>().doIntent(
              ValidateFieldsIntent(vehicleNumber: value),
            );
          },
        ),
        24.verticalSpacing,
        const UploadLicenseField(),
        24.verticalSpacing,
        TextFormField(
          controller: widget.emailController,
          decoration: InputDecoration(labelText: AppTextString.emailLabel),
          style: textStyle,
          validator: AppValidators.validateEmail,
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          onChanged: (value) {
            context.read<ApplyCubit>().doIntent(
              ValidateFieldsIntent(email: value),
            );
          },
        ),
        24.verticalSpacing,
        TextFormField(
          controller: widget.phoneNumberController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: AppTextString.phoneNumberLabel,
          ),
          style: textStyle,
          validator: AppValidators.validatePhoneNumber,
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          onChanged: (value) {
            context.read<ApplyCubit>().doIntent(
              ValidateFieldsIntent(phone: value),
            );
          },
        ),
        24.verticalSpacing,
        TextFormField(
          controller: widget.nationalIdController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: AppTextString.nationalIdLabel),
          style: textStyle,
          validator: AppValidators.validateNationalId,
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          onChanged: (value) {
            context.read<ApplyCubit>().doIntent(
              ValidateFieldsIntent(nationalId: value),
            );
          },
        ),
        24.verticalSpacing,
        const UploadNationalIdImgField(),
        24.verticalSpacing,
        PasswordFlieldsWidget(
          passwordController: widget.passwordController,
          confirmPasswordController: widget.confirmPasswordController,
        ),
        24.verticalSpacing,
        const GenderSectionWidget(),
      ],
    );
  }
}
