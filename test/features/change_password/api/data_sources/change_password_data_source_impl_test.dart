import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/config/exception/app_exception.dart';
import 'package:tracking_app/config/exception/network_exception.dart';
import 'package:tracking_app/config/exception/server_exception.dart';
import 'package:tracking_app/features/taps/profile_tab/change_password/api/api_client/change_password_api_client.dart';
import 'package:tracking_app/features/taps/profile_tab/change_password/api/data_sources/change_password_data_source_impl.dart';
import 'package:tracking_app/features/taps/profile_tab/change_password/data/models/change_password_request_model.dart';
import 'package:tracking_app/features/taps/profile_tab/change_password/data/models/change_password_response_model.dart';

import 'change_password_data_source_impl_test.mocks.dart';

@GenerateMocks([ChangePasswordApiClient])
void main() {
  late ChangePasswordDataSourceImpl dataSource;
  late MockChangePasswordApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockChangePasswordApiClient();
    dataSource = ChangePasswordDataSourceImpl(mockApiClient);
  });

  group('ChangePasswordDataSourceImpl', () {
    const changePasswordRequestModel = ChangePasswordRequestModel(
      password: 'OldPassword123!',
      newPassword: 'NewPassword123!',
    );

    const changePasswordResponseModel = ChangePasswordResponseModel(
      message: 'Password changed successfully',
      token: 'new_jwt_token_here',
    );

    test(
      'should return success BaseResponse when api client returns ChangePasswordResponseModel',
      () async {
        // Arrange
        when(
          mockApiClient.changePassword(any),
        ).thenAnswer((_) async => changePasswordResponseModel);

        // Act
        final result = await dataSource.changePassword(
          changePasswordRequestModel,
        );

        // Assert
        expect(result, isA<BaseResponse<ChangePasswordResponseModel>>());
        result.when(
          success: (data) {
            expect(data.message, 'Password changed successfully');
            expect(data.token, 'new_jwt_token_here');
          },
          failure: (_) => fail('Expected success but got failure'),
        );

        verify(mockApiClient.changePassword(any)).called(1);
        verifyNoMoreInteractions(mockApiClient);
      },
    );

    test(
      'should return failure BaseResponse when api client throws NetworkException',
      () async {
        // Arrange
        final exception = NetworkException(message: 'Network error');

        when(mockApiClient.changePassword(any)).thenThrow(exception);

        // Act
        final result = await dataSource.changePassword(
          changePasswordRequestModel,
        );

        // Assert
        expect(result, isA<BaseResponse<ChangePasswordResponseModel>>());
        result.when(
          success: (_) => fail('Expected failure but got success'),
          failure: (appException) {
            expect(appException, isA<AppException>());
            expect(appException.message, 'Network error');
          },
        );

        verify(mockApiClient.changePassword(any)).called(1);
        verifyNoMoreInteractions(mockApiClient);
      },
    );

    test('should handle 400 Bad Request error', () async {
      // Arrange
      final exception = ServerException(
        statusCode: 400,
        message: 'Invalid request',
      );

      when(mockApiClient.changePassword(any)).thenThrow(exception);

      // Act
      final result = await dataSource.changePassword(
        changePasswordRequestModel,
      );

      // Assert
      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (appException) {
          expect(appException, isA<ServerException>());
          expect((appException as ServerException).statusCode, 400);
        },
      );
    });

    test('should handle 401 Unauthorized error', () async {
      // Arrange
      final exception = ServerException(
        statusCode: 401,
        message: 'Unauthorized access',
      );

      when(mockApiClient.changePassword(any)).thenThrow(exception);

      // Act
      final result = await dataSource.changePassword(
        changePasswordRequestModel,
      );

      // Assert
      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (appException) {
          expect(appException, isA<ServerException>());
          expect((appException as ServerException).statusCode, 401);
        },
      );
    });

    test('should handle 403 Forbidden error', () async {
      // Arrange
      final exception = ServerException(statusCode: 403, message: 'Forbidden');

      when(mockApiClient.changePassword(any)).thenThrow(exception);

      // Act
      final result = await dataSource.changePassword(
        changePasswordRequestModel,
      );

      // Assert
      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (appException) {
          expect(appException, isA<ServerException>());
          expect((appException as ServerException).statusCode, 403);
        },
      );
    });

    test('should handle 404 Not Found error', () async {
      // Arrange
      final exception = ServerException(
        statusCode: 404,
        message: 'Resource not found',
      );

      when(mockApiClient.changePassword(any)).thenThrow(exception);

      // Act
      final result = await dataSource.changePassword(
        changePasswordRequestModel,
      );

      // Assert
      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (appException) {
          expect(appException, isA<ServerException>());
          expect((appException as ServerException).statusCode, 404);
        },
      );
    });

    test('should handle 422 Unprocessable Entity error', () async {
      // Arrange
      final exception = ServerException(
        statusCode: 422,
        message: 'Validation failed',
      );

      when(mockApiClient.changePassword(any)).thenThrow(exception);

      // Act
      final result = await dataSource.changePassword(
        changePasswordRequestModel,
      );

      // Assert
      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (appException) {
          expect(appException, isA<ServerException>());
          expect((appException as ServerException).statusCode, 422);
        },
      );
    });

    test('should handle 429 Too Many Requests error', () async {
      // Arrange
      final exception = ServerException(
        statusCode: 429,
        message: 'Too many requests',
      );

      when(mockApiClient.changePassword(any)).thenThrow(exception);

      // Act
      final result = await dataSource.changePassword(
        changePasswordRequestModel,
      );

      // Assert
      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (appException) {
          expect(appException, isA<ServerException>());
          expect((appException as ServerException).statusCode, 429);
        },
      );
    });

    test('should handle 500 Internal Server Error', () async {
      // Arrange
      final exception = ServerException(
        statusCode: 500,
        message: 'Internal server error',
      );

      when(mockApiClient.changePassword(any)).thenThrow(exception);

      // Act
      final result = await dataSource.changePassword(
        changePasswordRequestModel,
      );

      // Assert
      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (appException) {
          expect(appException, isA<ServerException>());
          expect((appException as ServerException).statusCode, 500);
        },
      );
    });

    test('should handle 502 Bad Gateway error', () async {
      // Arrange
      final exception = ServerException(
        statusCode: 502,
        message: 'Bad gateway',
      );

      when(mockApiClient.changePassword(any)).thenThrow(exception);

      // Act
      final result = await dataSource.changePassword(
        changePasswordRequestModel,
      );

      // Assert
      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (appException) {
          expect(appException, isA<ServerException>());
          expect((appException as ServerException).statusCode, 502);
        },
      );
    });

    test('should handle 503 Service Unavailable error', () async {
      // Arrange
      final exception = ServerException(
        statusCode: 503,
        message: 'Service unavailable',
      );

      when(mockApiClient.changePassword(any)).thenThrow(exception);

      // Act
      final result = await dataSource.changePassword(
        changePasswordRequestModel,
      );

      // Assert
      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (appException) {
          expect(appException, isA<ServerException>());
          expect((appException as ServerException).statusCode, 503);
        },
      );
    });

    test('should handle 504 Gateway Timeout error', () async {
      // Arrange
      final exception = ServerException(
        statusCode: 504,
        message: 'Gateway timeout',
      );

      when(mockApiClient.changePassword(any)).thenThrow(exception);

      // Act
      final result = await dataSource.changePassword(
        changePasswordRequestModel,
      );

      // Assert
      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (appException) {
          expect(appException, isA<ServerException>());
          expect((appException as ServerException).statusCode, 504);
        },
      );
    });

    test('should handle ServerException with response data', () async {
      // Arrange
      final exception = ServerException(
        statusCode: 422,
        message: 'Validation error',
        responseData: {
          'errors': {
            'password': ['Password is too weak'],
            'newPassword': ['Password must contain special characters'],
          },
        },
      );

      when(mockApiClient.changePassword(any)).thenThrow(exception);

      // Act
      final result = await dataSource.changePassword(
        changePasswordRequestModel,
      );

      // Assert
      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (appException) {
          expect(appException, isA<ServerException>());
          final serverException = appException as ServerException;
          expect(serverException.statusCode, 422);
          expect(serverException.responseData, isNotNull);
          expect(serverException.responseData!['errors'], isNotNull);
        },
      );
    });

    test('should return new token after successful password change', () async {
      // Arrange
      const responseWithToken = ChangePasswordResponseModel(
        message: 'Password updated',
        token: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...',
      );

      when(
        mockApiClient.changePassword(any),
      ).thenAnswer((_) async => responseWithToken);

      // Act
      final result = await dataSource.changePassword(
        changePasswordRequestModel,
      );

      // Assert
      result.when(
        success: (data) {
          expect(data.token, isNotEmpty);
          expect(data.token, startsWith('eyJ'));
        },
        failure: (_) => fail('Expected success but got failure'),
      );
    });

    test('should pass correct request model to api client', () async {
      // Arrange
      const testRequest = ChangePasswordRequestModel(
        password: 'TestOld123!',
        newPassword: 'TestNew456!',
      );

      when(
        mockApiClient.changePassword(any),
      ).thenAnswer((_) async => changePasswordResponseModel);

      // Act
      await dataSource.changePassword(testRequest);

      // Assert
      verify(mockApiClient.changePassword(any)).called(1);
    });
  });
}
