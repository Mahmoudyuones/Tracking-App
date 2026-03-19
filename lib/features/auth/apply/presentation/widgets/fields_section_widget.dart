import 'package:flutter/material.dart';

import '../../../../../core/constants/app_text_string.dart';
import '../../../../../core/extention/spacing.dart';
import '../../../../../core/style/color/app_colors.dart';
import '../../../../../core/validators/app_validators.dart';
import '../../domain/entities/request/vehicle_types_entity.dart';
import 'upload_license_field_widget.dart';

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
  });
  final TextEditingController firstNameController;
  final TextEditingController secondNameController;
  final String? vehicleTypeController;
  final TextEditingController vehicleNumberController;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final TextEditingController nationalIdController;

  @override
  State<FieldsSectionWidget> createState() => _FieldsSectionWidgetState();
}

class _FieldsSectionWidgetState extends State<FieldsSectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.firstNameController,
          decoration: InputDecoration(
            labelText: AppTextString.firstLegalNameLabel,
          ),
          validator: AppValidators.validateRequired,
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        ),
        24.verticalSpacing,
        TextFormField(
          controller: widget.secondNameController,
          decoration: InputDecoration(
            labelText: AppTextString.secondLegalNameLabel,
          ),
          validator: AppValidators.validateRequired,
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
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
          onChanged: (value) {},
          validator: AppValidators.validateRequired,
          decoration: InputDecoration(
            labelText: AppTextString.vehicleTypeLabel,
          ),
        ),
        24.verticalSpacing,
        TextFormField(
          controller: widget.vehicleNumberController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: AppTextString.vehicleNumberLabel,
          ),
          validator: AppValidators.validateRequired,
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        ),
        24.verticalSpacing,
        const UploadLicenseField(),
        24.verticalSpacing,
        TextFormField(
          controller: widget.emailController,
          decoration: InputDecoration(labelText: AppTextString.emailLabel),
          validator: AppValidators.validateEmail,
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        ),
        24.verticalSpacing,
        TextFormField(
          controller: widget.phoneNumberController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: AppTextString.phoneNumberLabel,
          ),
          validator: AppValidators.validatePhoneNumber,
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        ),
        24.verticalSpacing,
        TextFormField(
          controller: widget.nationalIdController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: AppTextString.nationalIdLabel),
          validator: AppValidators.validateNationalId,
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        ),
      ],
    );
  }
}
