import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/features/auth/forget_password/api/api_client/forget_password_api_client.dart';
import 'package:tracking_app/features/auth/forget_password/api/data_sources/forget_password_data_source_impl.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/request/forget_password_request_model.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/request/reset_password_request_model.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/request/verify_code_request_model.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/response/forget_password_response_model.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/response/reset_password_response_model.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/response/verify_code_response_model.dart';

import 'forget_password_data_source_impl_test.mocks.dart';

@GenerateMocks([ForgetPasswordApiClient])
void main() {
  late ForgetPasswordDataSourceImpl dataSource;
  late MockForgetPasswordApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockForgetPasswordApiClient();
    dataSource = ForgetPasswordDataSourceImpl(mockApiClient);
  });

  const tEmail = 'test@example.com';
  final tRequest = ForgetPasswordRequestModel(email: tEmail);
  final tResponse = ForgetPasswordResponseModel(
    message: 'Success',
    info: 'Info',
  );

  group('forgetPassword', () {
    test(
      'should call apiClient.forgetPassword and return the result',
      () async {
        // arrange
        when(
          mockApiClient.forgetPassword(any),
        ).thenAnswer((_) async => tResponse);

        // act
        final result = await dataSource.forgetPassword(tRequest);

        // assert
        expect(result, tResponse);
        verify(mockApiClient.forgetPassword(tRequest));
      },
    );
  });

  group('verifyCode', () {
    final tVerifyRequest = VerifyCodeRequestModel('123456');
    final tVerifyResponse = VerifyCodeResponseModel(status: 'Success');

    test('should call apiClient.verifyCode and return the result', () async {
      // arrange
      when(
        mockApiClient.verifyCode(any),
      ).thenAnswer((_) async => tVerifyResponse);

      // act
      final result = await dataSource.verifyCode(tVerifyRequest);

      // assert
      expect(result, tVerifyResponse);
      verify(mockApiClient.verifyCode(tVerifyRequest));
    });
  });

  group('resetPassword', () {
    const tResetRequest = ResetPasswordRequestModel(
      email: 'test@example.com',
      newPassword: 'password123',
    );
    const tResetResponse = ResetPasswordResponseModel(
      message: 'Success',
      token: 'token',
    );

    test('should call apiClient.resetPassword and return the result', () async {
      // arrange
      when(
        mockApiClient.resetPassword(any),
      ).thenAnswer((_) async => tResetResponse);

      // act
      final result = await dataSource.resetPassword(tResetRequest);

      // assert
      expect(result, tResetResponse);
      verify(mockApiClient.resetPassword(tResetRequest));
    });
  });
}
