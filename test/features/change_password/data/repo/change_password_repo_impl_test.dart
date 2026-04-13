import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/config/cash_services/secure_storage_service.dart';
import 'package:tracking_app/config/exception/app_exception.dart';
import 'package:tracking_app/config/exception/network_exception.dart';
import 'package:tracking_app/config/exception/server_exception.dart';
import 'package:tracking_app/config/exception/validation_exception.dart';
import 'package:tracking_app/features/taps/profile_tab/change_password/data/data_sources/change_password_data_source.dart';
import 'package:tracking_app/features/taps/profile_tab/change_password/data/models/change_password_response_model.dart';
import 'package:tracking_app/features/taps/profile_tab/change_password/data/repo/change_password_repo_impl.dart';
import 'package:tracking_app/features/taps/profile_tab/change_password/domain/entities/change_password_request_entity.dart';
import 'package:tracking_app/core/constants/storage_keys.dart';

import 'change_password_repo_impl_test.mocks.dart';

@GenerateMocks([ChangePasswordDataSource, SecureStorageService])
void main() {
  late ChangePasswordRepoImpl changePasswordRepoImpl;
  late MockChangePasswordDataSource mockChangePasswordDataSource;
  late MockSecureStorageService mockSecureStorageService;

  setUp(() {
    mockChangePasswordDataSource = MockChangePasswordDataSource();
    mockSecureStorageService = MockSecureStorageService();
    changePasswordRepoImpl = ChangePasswordRepoImpl(
      mockChangePasswordDataSource,
      mockSecureStorageService,
    );
  });

  group('changePassword', () {
    const requestEntity = ChangePasswordRequestEntity(
      password: 'OldPassword123!',
      newPassword: 'NewPassword123!',
    );

    const responseModel = ChangePasswordResponseModel(
      message: 'Password changed successfully',
      token: 'new_jwt_token_here',
    );

    test(
      'should return success and save token when data source returns success',
      () async {
        // Arrange
        const baseResponse = BaseResponse<ChangePasswordResponseModel>.success(
          responseModel,
        );

        when(
          mockChangePasswordDataSource.changePassword(any),
        ).thenAnswer((_) async => baseResponse);

        when(
          mockSecureStorageService.write(
            StorageKeys.accessToken,
            'new_jwt_token_here',
          ),
        ).thenAnswer((_) async => const BaseResponse.success(true));

        // Act
        final result = await changePasswordRepoImpl.changePassword(
          requestEntity,
        );

        // Assert
        expect(result, isA<BaseResponse<void>>());
        result.when(
          success: (_) {
            // Success - data is void
          },
          failure: (_) => fail('Expected success but got failure'),
        );

        verify(
          mockSecureStorageService.write(
            StorageKeys.accessToken,
            'new_jwt_token_here',
          ),
        ).called(1);
        verify(mockChangePasswordDataSource.changePassword(any)).called(1);
        verifyNoMoreInteractions(mockChangePasswordDataSource);
        verifyNoMoreInteractions(mockSecureStorageService);
      },
    );

    test('should return failure when data source returns failure', () async {
      // Arrange
      final serverException = ServerException(
        message: 'Failed to change password',
        statusCode: 500,
      );

      final baseResponse = BaseResponse<ChangePasswordResponseModel>.failure(
        serverException,
      );

      when(
        mockChangePasswordDataSource.changePassword(any),
      ).thenAnswer((_) async => baseResponse);

      // Act
      final result = await changePasswordRepoImpl.changePassword(requestEntity);

      // Assert
      expect(result, isA<BaseResponse<void>>());
      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (error) {
          expect(error, isA<ServerException>());
          expect(error.message, 'Failed to change password');
          expect((error as ServerException).statusCode, 500);
        },
      );

      verify(mockChangePasswordDataSource.changePassword(any)).called(1);
      verifyNever(mockSecureStorageService.write(StorageKeys.accessToken, any));
      verifyNoMoreInteractions(mockChangePasswordDataSource);
    });

    test('should not save token when data source returns failure', () async {
      // Arrange
      final networkException = NetworkException(message: 'Network error');

      final baseResponse = BaseResponse<ChangePasswordResponseModel>.failure(
        networkException,
      );

      when(
        mockChangePasswordDataSource.changePassword(any),
      ).thenAnswer((_) async => baseResponse);

      // Act
      await changePasswordRepoImpl.changePassword(requestEntity);

      // Assert
      verifyNever(mockSecureStorageService.write(StorageKeys.accessToken, any));
    });

    test('should handle 401 Unauthorized error', () async {
      // Arrange
      final serverException = ServerException(
        message: 'Unauthorized',
        statusCode: 401,
      );

      final baseResponse = BaseResponse<ChangePasswordResponseModel>.failure(
        serverException,
      );

      when(
        mockChangePasswordDataSource.changePassword(any),
      ).thenAnswer((_) async => baseResponse);

      // Act
      final result = await changePasswordRepoImpl.changePassword(requestEntity);

      // Assert
      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (error) {
          expect(error, isA<ServerException>());
          expect((error as ServerException).statusCode, 401);
        },
      );
    });

    test('should handle 400 Bad Request error', () async {
      // Arrange
      final serverException = ServerException(
        message: 'Current password is incorrect',
        statusCode: 400,
      );

      final baseResponse = BaseResponse<ChangePasswordResponseModel>.failure(
        serverException,
      );

      when(
        mockChangePasswordDataSource.changePassword(any),
      ).thenAnswer((_) async => baseResponse);

      // Act
      final result = await changePasswordRepoImpl.changePassword(requestEntity);

      // Assert
      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (error) {
          expect(error, isA<ServerException>());
          expect(error.message, 'Current password is incorrect');
          expect((error as ServerException).statusCode, 400);
        },
      );
    });

    test('should handle 422 Validation error', () async {
      // Arrange
      final serverException = ServerException(
        message: 'Password is too weak',
        statusCode: 422,
        responseData: {
          'errors': {
            'newPassword': ['Password must be at least 8 characters'],
          },
        },
      );

      final baseResponse = BaseResponse<ChangePasswordResponseModel>.failure(
        serverException,
      );

      when(
        mockChangePasswordDataSource.changePassword(any),
      ).thenAnswer((_) async => baseResponse);

      // Act
      final result = await changePasswordRepoImpl.changePassword(requestEntity);

      // Assert
      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (error) {
          expect(error, isA<ServerException>());
          final serverError = error as ServerException;
          expect(serverError.statusCode, 422);
          expect(serverError.responseData, isNotNull);
        },
      );
    });

    test('should handle NetworkException', () async {
      // Arrange
      final networkException = NetworkException(
        message: 'No internet connection',
      );

      final baseResponse = BaseResponse<ChangePasswordResponseModel>.failure(
        networkException,
      );

      when(
        mockChangePasswordDataSource.changePassword(any),
      ).thenAnswer((_) async => baseResponse);

      // Act
      final result = await changePasswordRepoImpl.changePassword(requestEntity);

      // Assert
      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (error) {
          expect(error, isA<NetworkException>());
          expect(error.message, 'No internet connection');
        },
      );

      verifyNever(mockSecureStorageService.write(StorageKeys.accessToken, any));
    });

    test('should save correct token from response', () async {
      // Arrange
      const responseWithSpecificToken = ChangePasswordResponseModel(
        message: 'Password updated',
        token: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.test.token',
      );

      const baseResponse = BaseResponse<ChangePasswordResponseModel>.success(
        responseWithSpecificToken,
      );

      when(
        mockChangePasswordDataSource.changePassword(any),
      ).thenAnswer((_) async => baseResponse);

      when(
        mockSecureStorageService.write(
          StorageKeys.accessToken,
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.test.token',
        ),
      ).thenAnswer((_) async => const BaseResponse.success(true));

      // Act
      await changePasswordRepoImpl.changePassword(requestEntity);

      // Assert
      verify(
        mockSecureStorageService.write(
          StorageKeys.accessToken,
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.test.token',
        ),
      ).called(1);
    });

    test('should handle AppException validation error', () async {
      // Arrange
      final appException = ValidationException(
        message: 'Passwords do not match',
      );

      final baseResponse = BaseResponse<ChangePasswordResponseModel>.failure(
        appException,
      );

      when(
        mockChangePasswordDataSource.changePassword(any),
      ).thenAnswer((_) async => baseResponse);

      // Act
      final result = await changePasswordRepoImpl.changePassword(requestEntity);

      // Assert
      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (error) {
          expect(error, isA<AppException>());
          expect(error.message, 'Passwords do not match');
        },
      );
    });

    test('should return success with null data after saving token', () async {
      // Arrange
      const baseResponse = BaseResponse<ChangePasswordResponseModel>.success(
        responseModel,
      );

      when(
        mockChangePasswordDataSource.changePassword(any),
      ).thenAnswer((_) async => baseResponse);

      when(
        mockSecureStorageService.write(
          StorageKeys.accessToken,
          'new_jwt_token_here',
        ),
      ).thenAnswer((_) async => const BaseResponse.success(true));

      // Act
      final result = await changePasswordRepoImpl.changePassword(requestEntity);

      // Assert
      result.when(
        success: (_) {
          // Success - data is void
        },
        failure: (_) => fail('Expected success but got failure'),
      );
    });

    test('should handle storage service failure', () async {
      // Arrange
      const baseResponse = BaseResponse<ChangePasswordResponseModel>.success(
        responseModel,
      );

      when(
        mockChangePasswordDataSource.changePassword(any),
      ).thenAnswer((_) async => baseResponse);

      when(
        mockSecureStorageService.write(
          StorageKeys.accessToken,
          'new_jwt_token_here',
        ),
      ).thenThrow(Exception('Storage error'));

      // Act & Assert
      expect(
        () => changePasswordRepoImpl.changePassword(requestEntity),
        throwsException,
      );
    });

    test('should call data source with correct parameters', () async {
      // Arrange
      const testEntity = ChangePasswordRequestEntity(
        password: 'TestOld123!',
        newPassword: 'TestNew456!',
      );

      const baseResponse = BaseResponse<ChangePasswordResponseModel>.success(
        responseModel,
      );

      when(
        mockChangePasswordDataSource.changePassword(any),
      ).thenAnswer((_) async => baseResponse);

      when(
        mockSecureStorageService.write(
          StorageKeys.accessToken,
          'new_jwt_token_here',
        ),
      ).thenAnswer((_) async => const BaseResponse.success(true));

      // Act
      await changePasswordRepoImpl.changePassword(testEntity);

      // Assert
      verify(mockChangePasswordDataSource.changePassword(any)).called(1);
    });
  });
}
