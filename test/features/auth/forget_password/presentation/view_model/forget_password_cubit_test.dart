import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/auth/forget_password/domain/use_cases/forget_password_use_case.dart';
import 'package:tracking_app/features/auth/forget_password/domain/use_cases/reset_password_use_case.dart';
import 'package:tracking_app/features/auth/forget_password/domain/use_cases/verify_code_use_case.dart';
import 'package:tracking_app/features/auth/forget_password/presentation/view_model/forget_password_cubit/forget_password_cubit.dart';
import 'package:tracking_app/features/auth/forget_password/presentation/view_model/forget_password_cubit/forget_password_intents.dart';
import 'package:tracking_app/features/auth/forget_password/presentation/view_model/forget_password_cubit/forget_password_states.dart';
import 'package:tracking_app/features/auth/forget_password/presentation/view_model/forget_password_cubit/forget_password_ui_intents.dart';

import 'package:tracking_app/config/exception/unknown_exception.dart';
import 'forget_password_cubit_test.mocks.dart';

@GenerateMocks([ForgetPasswordUseCase, VerifyCodeUseCase, ResetPasswordUseCase])
void main() {
  late ForgetPasswordCubit cubit;
  late MockForgetPasswordUseCase mockForgetPasswordUseCase;
  late MockVerifyCodeUseCase mockVerifyCodeUseCase;
  late MockResetPasswordUseCase mockResetPasswordUseCase;

  setUp(() {
    mockForgetPasswordUseCase = MockForgetPasswordUseCase();
    mockVerifyCodeUseCase = MockVerifyCodeUseCase();
    mockResetPasswordUseCase = MockResetPasswordUseCase();

    cubit = ForgetPasswordCubit(
      forgetPasswordUseCase: mockForgetPasswordUseCase,
      verifyCodeUseCase: mockVerifyCodeUseCase,
      resetPasswordUseCase: mockResetPasswordUseCase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  group('ForgetPasswordCubit', () {
    test('initial state should be ForgetPasswordStates()', () {
      expect(cubit.state, const ForgetPasswordStates());
    });

    group('Provide Email Logic', () {
      blocTest<ForgetPasswordCubit, ForgetPasswordStates>(
        'should emit [isValidEmail: true] when email is valid',
        build: () => cubit,
        act: (cubit) => cubit.doIntent(EmailChangedIntent('test@example.com')),
        expect: () => [
          const ForgetPasswordStates(
            email: 'test@example.com',
            isValidEmail: true,
          ),
        ],
      );

      blocTest<ForgetPasswordCubit, ForgetPasswordStates>(
        'should emit [isValidEmail: false] when email is invalid',
        build: () => cubit,
        act: (cubit) => cubit.doIntent(EmailChangedIntent('invalid-email')),
        expect: () => [
          const ForgetPasswordStates(
            email: 'invalid-email',
            isValidEmail: false,
          ),
        ],
      );

      blocTest<ForgetPasswordCubit, ForgetPasswordStates>(
        'should add NavigateToVerifyIntent when confirmEmail is successful',
        build: () {
          when(
            mockForgetPasswordUseCase(any),
          ).thenAnswer((_) async => const BaseResponse.success(null));
          return cubit;
        },
        act: (cubit) async {
          final uiIntentsFuture = expectLater(
            cubit.uiIntents,
            emitsInOrder([
              isA<ShowLoadingProvideEmailIntent>(),
              isA<NavigateToVerifyIntent>(),
            ]),
          );

          cubit.doIntent(EmailChangedIntent('test@example.com'));
          cubit.doIntent(ConfirmEmailIntent());

          await uiIntentsFuture;
        },
        expect: () => [
          const ForgetPasswordStates(
            email: 'test@example.com',
            isValidEmail: true,
          ),
        ],
      );
    });

    group('Verify Code Logic', () {
      blocTest<ForgetPasswordCubit, ForgetPasswordStates>(
        'should emit [isValidOtp: true] when OTP is 6 digits',
        build: () => cubit,
        act: (cubit) => cubit.doIntent(OtpChangedIntent('123456')),
        expect: () => [
          const ForgetPasswordStates(code: '123456', isValidOtp: true),
        ],
      );

      blocTest<ForgetPasswordCubit, ForgetPasswordStates>(
        'should add NavigateToResetPasswordIntent when submitCode is successful',
        build: () {
          when(
            mockVerifyCodeUseCase(any),
          ).thenAnswer((_) async => const BaseResponse.success(null));
          return cubit;
        },
        act: (cubit) async {
          final uiIntentsFuture = expectLater(
            cubit.uiIntents,
            emitsInOrder([
              isA<ShowLoadingVerifyIntent>(),
              isA<NavigateToResetPasswordIntent>(),
            ]),
          );
          cubit.doIntent(OtpChangedIntent('123456'));
          cubit.doIntent(SubmitCodeIntent());
          await uiIntentsFuture;
        },
        expect: () => [
          const ForgetPasswordStates(code: '123456', isValidOtp: true),
        ],
      );
    });

    group('Reset Password Logic', () {
      blocTest<ForgetPasswordCubit, ForgetPasswordStates>(
        'should emit updated passwords and isValidForm',
        build: () => cubit,
        act: (cubit) {
          cubit.doIntent(NewPasswordChangedIntent('password123'));
          cubit.doIntent(ConfirmPasswordChangedIntent('password123'));
        },
        expect: () => [
          const ForgetPasswordStates(
            newPassword: 'password123',
            isValidForm: false, // confirmPassword still empty in first emit
          ),
          const ForgetPasswordStates(
            newPassword: 'password123',
            confirmPassword: 'password123',
            isValidForm: true,
          ),
        ],
      );

      blocTest<ForgetPasswordCubit, ForgetPasswordStates>(
        'should add NavigateToLoginIntent when resetPassword is successful',
        build: () {
          when(
            mockResetPasswordUseCase(any),
          ).thenAnswer((_) async => const BaseResponse.success(null));
          return cubit;
        },
        act: (cubit) async {
          final uiIntentsFuture = expectLater(
            cubit.uiIntents,
            emitsInOrder([
              isA<ShowLoadingResetPasswordIntent>(),
              isA<NavigateToLoginIntent>(),
            ]),
          );

          cubit.doIntent(EmailChangedIntent('test@example.com'));
          cubit.doIntent(NewPasswordChangedIntent('password123'));
          cubit.doIntent(ConfirmPasswordChangedIntent('password123'));
          cubit.doIntent(ConfirmResetPasswordIntent());

          await uiIntentsFuture;
        },
      );

      blocTest<ForgetPasswordCubit, ForgetPasswordStates>(
        'should add ShowErrorMsgResetPasswordIntent when resetPassword fails',
        build: () {
          when(mockResetPasswordUseCase(any)).thenAnswer(
            (_) async =>
                BaseResponse.failure(UnknownException(message: 'Reset failed')),
          );
          return cubit;
        },
        act: (cubit) async {
          final uiIntentsFuture = expectLater(
            cubit.uiIntents,
            emitsInOrder([
              isA<ShowLoadingResetPasswordIntent>(),
              isA<ShowErrorMsgResetPasswordIntent>(),
            ]),
          );

          cubit.doIntent(EmailChangedIntent('test@example.com'));
          cubit.doIntent(NewPasswordChangedIntent('password123'));
          cubit.doIntent(ConfirmPasswordChangedIntent('password123'));
          cubit.doIntent(ConfirmResetPasswordIntent());

          await uiIntentsFuture;
        },
      );
    });

    group('Common/Failure Scenarios', () {
      blocTest<ForgetPasswordCubit, ForgetPasswordStates>(
        'should add ShowErrorProvideEmailIntent when confirmEmail fails',
        build: () {
          when(mockForgetPasswordUseCase(any)).thenAnswer(
            (_) async =>
                BaseResponse.failure(UnknownException(message: 'API error')),
          );
          return cubit;
        },
        act: (cubit) async {
          final uiIntentsFuture = expectLater(
            cubit.uiIntents,
            emitsInOrder([
              isA<ShowLoadingProvideEmailIntent>(),
              isA<ShowErrorProvideEmailIntent>(),
            ]),
          );

          cubit.doIntent(EmailChangedIntent('test@example.com'));
          cubit.doIntent(ConfirmEmailIntent());

          await uiIntentsFuture;
        },
      );

      blocTest<ForgetPasswordCubit, ForgetPasswordStates>(
        'should add ShowErrorMsgVerifyIntent when submitCode fails',
        build: () {
          when(mockVerifyCodeUseCase(any)).thenAnswer(
            (_) async =>
                BaseResponse.failure(UnknownException(message: 'Invalid code')),
          );
          return cubit;
        },
        act: (cubit) async {
          final uiIntentsFuture = expectLater(
            cubit.uiIntents,
            emitsInOrder([
              isA<ShowLoadingVerifyIntent>(),
              isA<ShowErrorMsgVerifyIntent>(),
            ]),
          );

          cubit.doIntent(OtpChangedIntent('123456'));
          cubit.doIntent(SubmitCodeIntent());

          await uiIntentsFuture;
        },
      );
    });
  });
}
