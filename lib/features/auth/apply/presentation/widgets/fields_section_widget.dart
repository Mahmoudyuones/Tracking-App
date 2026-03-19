import 'package:flutter/material.dart';

import '../../../../../core/constants/app_text_string.dart';
import '../../../../../core/extention/spacing.dart';

class FieldsSectionWidget extends StatefulWidget {
  const FieldsSectionWidget({super.key});

  @override
  State<FieldsSectionWidget> createState() => _FieldsSectionWidgetState();
}

class _FieldsSectionWidgetState extends State<FieldsSectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: AppTextString.firstLegalNameLabel,
          ),
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        ),
        24.verticalSpacing,
        TextFormField(
          decoration: InputDecoration(
            labelText: AppTextString.secondLegalNameLabel,
          ),
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        ),
        24.verticalSpacing,
        DropdownButtonFormField(
          items: const [],
          onChanged: (value) {},
          decoration: InputDecoration(
            labelText: AppTextString.vehicleTypeLabel,
          ),
        ),
      ],
    );
  }
}
