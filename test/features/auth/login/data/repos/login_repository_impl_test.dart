import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/config/exception/server_exception.dart';
import 'package:tracking_app/features/auth/login/data/data_sources/local/login_local_data_source.dart';
import 'package:tracking_app/features/auth/login/data/data_sources/remote/login_remote_data_source.dart';
import 'package:tracking_app/features/auth/login/data/models/login_request_model/login_request_model.dart';
import 'package:tracking_app/features/auth/login/data/models/login_response_model/login_response_model.dart';
import 'package:tracking_app/features/auth/login/data/repos/login_repository_impl.dart';

import 'login_repository_impl_test.mocks.dart';

@GenerateMocks([LoginRemoteDataSource, LoginLocalDataSource])
void main() {
  late LoginRepositoryImpl repo;
  late MockLoginLocalDataSource mockLocalDataSource;
  late MockLoginRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockLocalDataSource = MockLoginLocalDataSource();
    mockRemoteDataSource = MockLoginRemoteDataSource();
    repo = LoginRepositoryImpl(mockRemoteDataSource, mockLocalDataSource);
  });

  group('All Tests Cases for Login Repository Implementation:', () {
    const tLoginRequest = LoginRequestModel(
      email: 'test@example.com',
      password: 'password123',
    );
    const tMessage = 'Login successful';
    const tToken = 'test_token_123';
    const tLoginResponse = LoginResponseModel(message: tMessage, token: tToken);

    test(
      'Success Test Case 1: Should return success response when remote login is successful and remembered is false',
      () async {
        // arrange
        when(
          mockRemoteDataSource.login(tLoginRequest),
        ).thenAnswer((_) async => const BaseResponse.success(tLoginResponse));

        // act
        final result = await repo.login(
          request: tLoginRequest,
          remembered: false,
        );

        // assert
        expect(result, const BaseResponse.success(tLoginResponse));
        verify(mockRemoteDataSource.login(tLoginRequest)).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
        verifyZeroInteractions(mockLocalDataSource);
      },
    );

    test(
      'Success Test Case 2: Should return success response and save token when remote login is successful and remembered is true',
      () async {
        // arrange
        when(
          mockRemoteDataSource.login(tLoginRequest),
        ).thenAnswer((_) async => const BaseResponse.success(tLoginResponse));
        when(
          mockLocalDataSource.saveLoggedUserData(token: tToken),
        ).thenAnswer((_) async => const BaseResponse.success(null));

        // act
        final result = await repo.login(
          request: tLoginRequest,
          remembered: true,
        );

        // assert
        expect(result, const BaseResponse.success(tLoginResponse));
        verify(mockRemoteDataSource.login(tLoginRequest)).called(1);
        verify(mockLocalDataSource.saveLoggedUserData(token: tToken)).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
        verifyNoMoreInteractions(mockLocalDataSource);
      },
    );

    test(
      'Success Test Case 3: Should return success response without saving token when remembered is true but token is null',
      () async {
        // arrange
        const tLoginResponseWithoutToken = LoginResponseModel(
          message: tMessage,
          token: null,
        );
        when(mockRemoteDataSource.login(tLoginRequest)).thenAnswer(
          (_) async => const BaseResponse.success(tLoginResponseWithoutToken),
        );

        // act
        final result = await repo.login(
          request: tLoginRequest,
          remembered: true,
        );

        // assert
        expect(result, const BaseResponse.success(tLoginResponseWithoutToken));
        verify(mockRemoteDataSource.login(tLoginRequest)).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
        verifyZeroInteractions(mockLocalDataSource);
      },
    );

    test(
      'Failure Test Case 1: Should return success response even when local save fails',
      () async {
        // arrange
        final tException = ServerException(
          message: 'Failed to save token',
          statusCode: 500,
        );
        when(
          mockRemoteDataSource.login(tLoginRequest),
        ).thenAnswer((_) async => const BaseResponse.success(tLoginResponse));
        when(
          mockLocalDataSource.saveLoggedUserData(token: tToken),
        ).thenAnswer((_) async => BaseResponse.failure(tException));

        // act
        final result = await repo.login(
          request: tLoginRequest,
          remembered: true,
        );

        // assert
        expect(result, const BaseResponse.success(tLoginResponse));
        verify(mockRemoteDataSource.login(tLoginRequest)).called(1);
        verify(mockLocalDataSource.saveLoggedUserData(token: tToken)).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
        verifyNoMoreInteractions(mockLocalDataSource);
      },
    );

    test(
      'Failure Test Case 2: Should return failure response when remote login fails',
      () async {
        // arrange
        final tException = ServerException(
          message: 'Invalid credentials',
          statusCode: 401,
        );
        when(
          mockRemoteDataSource.login(tLoginRequest),
        ).thenAnswer((_) async => BaseResponse.failure(tException));

        // act
        final result = await repo.login(
          request: tLoginRequest,
          remembered: false,
        );

        // assert
        result.when(
          success: (_) => fail('Should have failed'),
          failure: (e) => expect(e, tException),
        );
        verify(mockRemoteDataSource.login(tLoginRequest)).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
        verifyZeroInteractions(mockLocalDataSource);
      },
    );

    test(
      'Failure Test Case 3: Should return failure response when remote login fails and remembered is true',
      () async {
        // arrange
        final tException = ServerException(
          message: 'Server error',
          statusCode: 500,
        );
        when(
          mockRemoteDataSource.login(tLoginRequest),
        ).thenAnswer((_) async => BaseResponse.failure(tException));

        // act
        final result = await repo.login(
          request: tLoginRequest,
          remembered: true,
        );

        // assert
        result.when(
          success: (_) => fail('Should have failed'),
          failure: (e) => expect(e, tException),
        );
        verify(mockRemoteDataSource.login(tLoginRequest)).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
        verifyZeroInteractions(mockLocalDataSource);
      },
    );
    // ------------------------------ END OF TEST CASES ------------------------------ //
  });
}
