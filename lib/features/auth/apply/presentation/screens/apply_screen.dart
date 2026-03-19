import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/di/di.dart';
import '../../../../../core/constants/app_text_string.dart';
import '../../../../../core/extention/spacing.dart';
import '../../../../../core/style/color/app_colors.dart';
import '../../domain/entities/request/apply_request_entity.dart';
import '../cubit/apply_cubit.dart';
import '../cubit/apply_intents.dart';
import '../cubit/apply_state.dart';
import '../widgets/country_picker_widget.dart';
import '../widgets/fields_section_widget.dart';
import '../widgets/welcome_section_widget.dart';

class ApplyScreen extends StatefulWidget {
  const ApplyScreen({super.key});

  @override
  State<ApplyScreen> createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  late TextTheme textTheme;
  late ApplyCubit applyCubit;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController secondNameController = TextEditingController();
  String? vehicleType;
  TextEditingController vehicleNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController nationalIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    applyCubit = getIt<ApplyCubit>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    textTheme = Theme.of(context).textTheme;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppTextString.apply),
      ),
      body: BlocProvider(
        create: (context) => applyCubit,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const WelcomeSectionWidget(),
                  16.verticalSpacing,
                  const CountryPickerWidget(),
                  24.verticalSpacing,
                  FieldsSectionWidget(
                    firstNameController: firstNameController,
                    secondNameController: secondNameController,
                    vehicleTypeController: vehicleType,
                    vehicleNumberController: vehicleNumberController,
                    emailController: emailController,
                    phoneNumberController: phoneNumberController,
                    nationalIdController: nationalIdController,
                    passwordController: passwordController,
                    confirmPasswordController: confirmPasswordController,
                  ),
                  24.verticalSpacing,
                  SizedBox(
                    width: double.infinity,
                    child: BlocBuilder<ApplyCubit, ApplyState>(
                      buildWhen: (previous, current) =>
                          previous.fieldsValidation != current.fieldsValidation,
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate() &&
                                state.fieldsValidation) {
                              formKey.currentState!.save();
                              applyCubit.doIntent(
                                SubmitApplyIntent(
                                  request: ApplyRequestEntity(
                                    country: state.selectedCountry!.name,
                                    firstName: firstNameController.text,
                                    lastName: secondNameController.text,
                                    vehicleType: vehicleType!,
                                    vehicleNumber: vehicleNumberController.text,
                                    vehicleLicense: state.vehicleLicense!,
                                    nID: nationalIdController.text,
                                    nIDImg: state.nationalIdImg!,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    rePassword: confirmPasswordController.text,
                                    gender: state.gender!,
                                    phone: phoneNumberController.text,
                                  ),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: state.fieldsValidation
                                ? AppColors.primary
                                : AppColors.primary.withValues(alpha: 0.5),
                          ),
                          child: Text(AppTextString.continueText),
                        );
                      },
                    ),
                  ),
                  8.verticalSpacing,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
