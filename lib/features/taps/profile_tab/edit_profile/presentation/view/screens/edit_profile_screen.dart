import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../../config/di/di.dart';
import '../../../../../../../core/constants/app_text_string.dart';
import '../../../../../../../core/routes/app_routes.dart';
import '../../../../../../../core/style/color/app_colors.dart';
import '../../../../../../../core/utility/ui/ui_utils.dart';
import '../../../../my_profile/domain/entities/driver_entity.dart';
import '../../view_model/edit_profile_cubit.dart';
import '../../view_model/edit_profile_intents.dart';
import '../../view_model/edit_profile_states.dart';
import '../../view_model/edit_profile_ui_intents.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.driver});

  final DriverEntity driver;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _imageFile;
  final imagePicker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  late EditProfileCubit _editProfileCubit;

  @override
  void initState() {
    super.initState();
    _editProfileCubit = getIt<EditProfileCubit>()
      ..loadFromDriver(
        firstName: widget.driver.firstName,
        lastName: widget.driver.lastName,
        email: widget.driver.email,
        phone: widget.driver.phone,
        photoUrl: widget.driver.photo,
      );

    _editProfileCubit.uiIntentsStream.listen((intent) {
      if (!mounted) return;
      switch (intent) {
        case ShowLoadingIntent():
          UIUtils.showEasyLoading();
        case ShowErrorIntent(:final message):
          _handleFailure(message);
        case ShowPhotoLoadingIntent():
          UIUtils.showEasyLoading();
        case UpdateProfileSuccessIntent():
          _handleSuccess(intent.message);
        case UpdatePhotoSuccessIntent():
          _handlePhotoSuccess();
      }
    });
  }

  void _handleFailure(String message) {
    UIUtils.hideLoading(context);
    UIUtils.showMessage(
      message,
      backGroundColor: AppColors.red,
      textColor: AppColors.white,
    );
  }

  void _handleSuccess(String message) {
    UIUtils.hideLoading(context);
    UIUtils.showMessage(
      message,
      backGroundColor: AppColors.green,
      textColor: AppColors.white,
    );
    context.pop();
  }

  void _handlePhotoSuccess() {
    UIUtils.hideLoading(context);
  }

  Future<void> _pickImage() async {
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (mounted && pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
      _editProfileCubit.doIntent(UpdateProfilePhotoIntent(_imageFile!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _editProfileCubit,
      child: Scaffold(
        appBar: AppBar(title: Text(AppTextString.editProfile)),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!) as ImageProvider
                          : NetworkImage(widget.driver.photo) as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: AppColors.whiteLight,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            size: 18,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              initialValue: widget.driver.firstName,
                              style: Theme.of(context).textTheme.titleMedium,
                              decoration: InputDecoration(
                                labelText: AppTextString.firstName,
                              ),
                              onChanged: (value) {
                                _editProfileCubit.doIntent(
                                  FirstNameChangedIntent(value),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: TextFormField(
                              initialValue: widget.driver.lastName,
                              style: Theme.of(context).textTheme.titleMedium,

                              decoration: InputDecoration(
                                labelText: AppTextString.lastName,
                              ),
                              onChanged: (value) {
                                _editProfileCubit.doIntent(
                                  LastNameChangedIntent(value),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      TextFormField(
                        initialValue: widget.driver.email,
                        style: Theme.of(context).textTheme.titleMedium,
                        decoration: InputDecoration(
                          labelText: AppTextString.emailLabel,
                        ),
                        onChanged: (value) {
                          context.read<EditProfileCubit>().doIntent(
                            EmailChangedIntent(value),
                          );
                        },
                      ),
                      const SizedBox(height: 25),
                      TextFormField(
                        initialValue: widget.driver.phone,
                        style: Theme.of(context).textTheme.titleMedium,
                        decoration: InputDecoration(
                          labelText: AppTextString.phoneNumberLabel,
                        ),
                        onChanged: (value) {
                          _editProfileCubit.doIntent(PhoneChangedIntent(value));
                        },
                      ),
                      const SizedBox(height: 25),
                      TextFormField(
                        obscureText: true,
                        readOnly: true,
                        cursorColor: AppColors.black,
                        canRequestFocus: false,
                        decoration: InputDecoration(
                          labelText: AppTextString.passwordLabel,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffix: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ...List.generate(
                                6,
                                (index) => const Icon(
                                  Icons.star,
                                  size: 20,
                                  color: AppColors.black,
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () async {
                                  final result = await context.pushNamed(
                                    AppRoutes.changePasswordRoute,
                                  );
                                  if (!mounted) return;
                                  if (result == true) {
                                    _editProfileCubit.doIntent(
                                      const UpdateProfileSubmitIntent(),
                                    );
                                  }
                                },
                                child: Text(
                                  AppTextString.change,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: BlocBuilder<EditProfileCubit, EditProfileStates>(
                          buildWhen: (prev, curr) =>
                              prev.isDirty != curr.isDirty ||
                              prev.isValidForm != curr.isValidForm,
                          builder: (context, state) => ElevatedButton(
                            onPressed: (state.isDirty && state.isValidForm)
                                ? () {
                                    if (_formKey.currentState!.validate()) {
                                      _editProfileCubit.doIntent(
                                        const UpdateProfileSubmitIntent(),
                                      );
                                    }
                                  }
                                : null,
                            child: Text(
                              AppTextString.update,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(color: AppColors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
