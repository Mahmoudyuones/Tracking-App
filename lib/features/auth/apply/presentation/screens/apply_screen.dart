import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/di/di.dart';
import '../../../../../core/constants/app_text_string.dart';
import '../../../../../core/extention/spacing.dart';
import '../cubit/apply_cubit.dart';
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
                ),
                24.verticalSpacing,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
