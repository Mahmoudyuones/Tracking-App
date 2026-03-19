import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_text_string.dart';
import '../../../../../core/extention/spacing.dart';
import '../../../../../core/style/color/app_colors.dart';
import '../cubit/apply_cubit.dart';
import '../cubit/apply_intents.dart';
import '../cubit/apply_state.dart';

class CountryPickerWidget extends StatefulWidget {
  const CountryPickerWidget({super.key});

  @override
  State<CountryPickerWidget> createState() => _CountryPickerWidgetState();
}

class _CountryPickerWidgetState extends State<CountryPickerWidget> {
  void _openCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: (Country country) {
        context.read<ApplyCubit>().doIntent(
          SelectCountryIntent(country: country),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplyCubit, ApplyState>(
      buildWhen: (previous, current) =>
          previous.selectedCountry != current.selectedCountry,
      builder: (context, state) {
        return InputDecorator(
          decoration: InputDecoration(
            labelText: AppTextString.country,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: AppColors.inputBorder),
            ),
          ),
          child: GestureDetector(
            onTap: _openCountryPicker,
            child: Row(
              children: [
                Text(state.selectedCountry?.flagEmoji ?? ''),
                8.horizontalSpacing,
                Expanded(
                  child: Text(
                    state.selectedCountry?.name ?? AppTextString.selectCountry,
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.inputBorder,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
