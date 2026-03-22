import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_text_string.dart';
import '../../../../../core/constants/validation_constants.dart';
import '../../../../../core/extention/spacing.dart';
import '../../../../../core/style/color/app_colors.dart';
import '../cubit/apply_cubit.dart';
import '../cubit/apply_intents.dart';
import '../cubit/apply_state.dart';

class CountryPickerWidget extends StatefulWidget {
  const CountryPickerWidget({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;

  @override
  State<CountryPickerWidget> createState() => _CountryPickerWidgetState();
}

class _CountryPickerWidgetState extends State<CountryPickerWidget> {
  void _openCountryPicker(FormFieldState<Country> formFieldState) {
    bool countrySelected = false;

    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: (Country selectedCountry) {
        countrySelected = true;
        context.read<ApplyCubit>().doIntent(
          SelectCountryIntent(country: selectedCountry),
        );
        formFieldState.didChange(selectedCountry);
        context.read<ApplyCubit>().doIntent(
          ValidateFieldsIntent(
            formsValid: widget.formKey.currentState!.validate(),
          ),
        );
      },
      onClosed: () {
        if (!countrySelected) {
          formFieldState.validate();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormField<Country>(
      validator: (value) {
        if (value == null) {
          return ValidationConstants.fieldRequired;
        }
        return null;
      },
      builder: (formFieldState) {
        return BlocBuilder<ApplyCubit, ApplyState>(
          buildWhen: (previous, current) =>
              previous.selectedCountry != current.selectedCountry,
          builder: (context, state) {
            return InputDecorator(
              decoration: InputDecoration(
                labelText: AppTextString.country,
                errorText: formFieldState.errorText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: AppColors.inputBorder),
                ),
              ),
              child: GestureDetector(
                onTap: () => _openCountryPicker(formFieldState),
                child: Row(
                  children: [
                    Text(state.selectedCountry?.flagEmoji ?? ''),
                    8.horizontalSpacing,
                    Expanded(
                      child: Text(
                        state.selectedCountry?.name ??
                            AppTextString.selectCountry,
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
      },
    );
  }
}
