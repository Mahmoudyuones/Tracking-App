import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/auth/forget_password/data/data_sources/forget_password_data_source.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/request/forget_password_request_model.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/request/reset_password_request_model.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/request/verify_code_request_model.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/response/forget_password_response_model.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/response/reset_password_response_model.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/response/verify_code_response_model.dart';
import 'package:tracking_app/features/auth/forget_password/data/repositories/forget_password_repository_impl.dart';

import 'forget_password_repository_impl_test.mocks.dart';

@GenerateMocks([ForgetPasswordDataSource])
void main() {
  late ForgetPasswordRepositoryImpl repository;
  late MockForgetPasswordDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockForgetPasswordDataSource();
    repository = ForgetPasswordRepositoryImpl(mockDataSource);
  });

  const tEmail = 'test@example.com';
  final tRequest = ForgetPasswordRequestModel(email: tEmail);
  final tResponse = ForgetPasswordResponseModel(
    message: 'Success',
    info: 'Info',
  );

  group('forgetPassword', () {
    test('should return success when data source call is successful', () async {
      // arrange
      when(
        mockDataSource.forgetPassword(any),
      ).thenAnswer((_) async => tResponse);

      // act
      final result = await repository.forgetPassword(tRequest);

      // assert
      expect(result, const BaseResponse<void>.success(null));
      verify(mockDataSource.forgetPassword(tRequest));
    });

    test(
      'should return failure when data source call throws exception',
      () async {
        // arrange
        when(mockDataSource.forgetPassword(any)).thenThrow(Exception());

        // act
        final result = await repository.forgetPassword(tRequest);

        // assert
        expect(result, isA<Failure>());
        verify(mockDataSource.forgetPassword(tRequest));
      },
    );
  });

  group('verifyCode', () {
    final tVerifyRequest = VerifyCodeRequestModel('123456');
    final tVerifyResponse = VerifyCodeResponseModel(status: 'Success');

    test('should return success when data source call is successful', () async {
      // arrange
      when(
        mockDataSource.verifyCode(any),
      ).thenAnswer((_) async => tVerifyResponse);

      // act
      final result = await repository.verifyCode(tVerifyRequest);

      // assert
      expect(result, const BaseResponse<void>.success(null));
      verify(mockDataSource.verifyCode(tVerifyRequest));
    });
  });

  group('resetCode', () {
    const tResetRequest = ResetPasswordRequestModel(
      email: 'test@example.com',
      newPassword: 'password123',
    );
    const tResetResponse = ResetPasswordResponseModel(
      message: 'Success',
      token: 'token',
    );

    test('should return success when data source call is successful', () async {
      // arrange
      when(
        mockDataSource.resetPassword(any),
      ).thenAnswer((_) async => tResetResponse);

      // act
      final result = await repository.resetCode(tResetRequest);

      // assert
      expect(result, const BaseResponse<void>.success(null));
      verify(mockDataSource.resetPassword(tResetRequest));
    });
  });
}
