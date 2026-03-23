import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../config/di/di.dart';
import '../../../../../core/constants/app_text_string.dart';
import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/style/color/app_colors.dart';
import '../../../../../core/utility/ui/ui_utils.dart';
import '../../view_model/my_profile_cubit.dart';
import '../../view_model/my_profile_events.dart';
import '../../view_model/my_profile_state.dart';
import '../../view_model/my_profile_ui_events.dart';
import '../widgets/language_bottom_sheet.dart';
import '../widgets/language_card.dart';
import '../widgets/logout_card.dart';
import '../widgets/logout_dialog.dart';
import '../widgets/profile_appbar.dart';
import '../widgets/user_info_card.dart';
import '../widgets/vehicle_info_card.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  late final MyProfileCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<MyProfileCubit>();
    _cubit.uiEventStream.listen((event) {
      if (!mounted) return;
      switch (event) {
        case LoadingUiEvent():
          UIUtils.showEasyLoading();
        case ErrorUiEvent():
          _handleError(event.message);
        case SuccessUiEvent():
          UIUtils.hideLoading(context);
        case ShowLanguageBottomSheetEvent():
          _showLanguageBottomSheet();
        case ShowLogoutDialogEvent():
          _showLogoutDialog();
        case LogoutSuccessUiEvent():
          UIUtils.hideLoading(context);
          context.goNamed(AppRoutes.loginRoute);
      }
    });
    _cubit.onEvent(GetDriverProfileDataEvent());
  }

  void _handleError(String message) {
    UIUtils.hideLoading(context);
    UIUtils.showMessage(
      message,
      backGroundColor: AppColors.red,
      textColor: AppColors.white,
    );
  }

  void _showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => const LanguageBottomSheet(),
    );
  }

  void _showLogoutDialog() {
    UIUtils.hideLoading(context);
    LogoutDialog.show(context, _cubit);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: SafeArea(
        child: Column(
          children: [
            const ProfileAppBar(),
            BlocBuilder<MyProfileCubit, MyProfileState>(
              builder: (context, state) {
                final profileState = state.myProfileState;

                if (profileState.data == null &&
                    profileState.errorMessage == null) {
                  return const SizedBox.shrink();
                }

                if (profileState.errorMessage != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline_rounded,
                          size: 48,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          profileState.errorMessage!,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.error,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () =>
                              _cubit.onEvent(GetDriverProfileDataEvent()),
                          child: Text(AppTextString.retry),
                        ),
                      ],
                    ),
                  );
                }

                final driver = profileState.data!.driver;

                return Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        final cubit = context.read<MyProfileCubit>();
                        await context.pushNamed(
                          AppRoutes.editProfile,
                          extra: driver,
                        );
                        if (!mounted) return;
                        cubit.onEvent(GetDriverProfileDataEvent());
                      },
                      child: UserInfoCard(
                        name: '${driver.firstName} ${driver.lastName}',
                        email: driver.email,
                        phone: driver.phone,
                        image: driver.photo,
                      ),
                    ),
                    const SizedBox(height: 12),
                    VehicleInfoCard(
                      type: driver.vehicleType,
                      number: driver.vehicleNumber,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 12),
            const LanguageCard(),
            const LogoutCard(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
