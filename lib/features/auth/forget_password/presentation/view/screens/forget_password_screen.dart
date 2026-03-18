import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../config/di/di.dart';
import '../../../../../../../core/constants/app_text_string.dart';
import '../../view_model/forget_password_cubit/forget_password_cubit.dart';
import '../views/provide_email_view.dart';
import '../views/reset_password_view.dart';
import '../views/verify_code_view.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToNext() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ForgetPasswordCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppTextString.passwordLabel,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              if (_currentPage > 0) {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              } else {
                Navigator.pop(context);
              }
            },
            style: IconButton.styleFrom(padding: EdgeInsets.zero),
          ),
        ),
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          children: [
            ProvideEmailView(
              onSuccess: (email) {
                _navigateToNext();
              },
            ),
            VerifyCodeView(
              onSuccess: () {
                _navigateToNext();
              },
            ),
            const ResetPasswordView(),
          ],
        ),
      ),
    );
  }
}
