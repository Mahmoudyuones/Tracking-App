import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/config/exception/server_exception.dart';
import 'package:tracking_app/features/auth/login/data/models/login_request_model/login_request_model.dart';
import 'package:tracking_app/features/auth/login/data/models/login_response_model/login_response_model.dart';
import 'package:tracking_app/features/auth/login/domain/repos/login_repository.dart';
import 'package:tracking_app/features/auth/login/domain/use_cases/login_use_case.dart';

import 'login_use_case_test.mocks.dart';

@GenerateMocks([LoginRepository])
void main() {
  late LoginUseCase loginUseCase;
  late MockLoginRepository mockedRepo;

  setUp(() {
    mockedRepo = MockLoginRepository();
    loginUseCase = LoginUseCase(mockedRepo);
  });

  group('All Tests Cases for Login Use Case', () {
    const tLoginRequest = LoginRequestModel(
      email: 'test@example.com',
      password: 'password123',
    );
    const tToken = 'test_token_123';
    const tMessage = 'Login successful';
    const tLoginResponse = LoginResponseModel(message: tMessage, token: tToken);

    test(
      'Success Test Case 1: Should call repository login method with correct parameters when isRemembered is false',
      () async {
        // arrange
        when(
          mockedRepo.login(request: tLoginRequest, remembered: false),
        ).thenAnswer((_) async => const BaseResponse.success(tLoginResponse));

        // act
        await loginUseCase.call(request: tLoginRequest, isRemembered: false);

        // assert
        verify(
          mockedRepo.login(request: tLoginRequest, remembered: false),
        ).called(1);
        verifyNoMoreInteractions(mockedRepo);
      },
    );

    test(
      'Success Test Case 2: Should call repository login method with correct parameters when isRemembered is true',
      () async {
        // arrange
        when(
          mockedRepo.login(request: tLoginRequest, remembered: true),
        ).thenAnswer((_) async => const BaseResponse.success(tLoginResponse));

        // act
        await loginUseCase.call(request: tLoginRequest, isRemembered: true);

        // assert
        verify(
          mockedRepo.login(request: tLoginRequest, remembered: true),
        ).called(1);
        verifyNoMoreInteractions(mockedRepo);
      },
    );

    test(
      'Success Test Case 3: Should return success response when repository returns success',
      () async {
        // arrange
        when(
          mockedRepo.login(request: tLoginRequest, remembered: false),
        ).thenAnswer((_) async => const BaseResponse.success(tLoginResponse));

        // act
        final result = await loginUseCase.call(
          request: tLoginRequest,
          isRemembered: false,
        );

        // assert
        expect(result, const BaseResponse.success(tLoginResponse));
        verify(
          mockedRepo.login(request: tLoginRequest, remembered: false),
        ).called(1);
      },
    );

    test(
      'Success Test Case 4: Should propagate success response with token when isRemembered is true',
      () async {
        // arrange
        when(
          mockedRepo.login(request: tLoginRequest, remembered: true),
        ).thenAnswer((_) async => const BaseResponse.success(tLoginResponse));
        // act
        final result = await loginUseCase.call(
          request: tLoginRequest,
          isRemembered: true,
        );
        // assert
        result.when(
          success: (response) {
            expect(response.token, tToken);
            expect(response.message, tMessage);
          },
          failure: (_) => fail('Should have succeeded'),
        );
        verify(
          mockedRepo.login(request: tLoginRequest, remembered: true),
        ).called(1);
      },
    );

    test(
      'Success Test Case 5: Should handle response with null token',
      () async {
        // arrange
        const tResponseWithoutToken = LoginResponseModel(
          message: tMessage,
          token: null,
        );
        when(
          mockedRepo.login(request: tLoginRequest, remembered: false),
        ).thenAnswer(
          (_) async => const BaseResponse.success(tResponseWithoutToken),
        );

        // act
        final result = await loginUseCase.call(
          request: tLoginRequest,
          isRemembered: false,
        );

        // assert
        result.when(
          success: (response) {
            expect(response.token, isNull);
            expect(response.message, tMessage);
          },
          failure: (_) => fail('Should have succeeded'),
        );
      },
    );

    test(
      'Failure Test Case 1: Should return failure response when repository returns failure',
      () async {
        // arrange
        final tException = ServerException(
          message: 'Invalid credentials',
          statusCode: 401,
        );
        when(
          mockedRepo.login(request: tLoginRequest, remembered: false),
        ).thenAnswer((_) async => BaseResponse.failure(tException));

        // act
        final result = await loginUseCase.call(
          request: tLoginRequest,
          isRemembered: false,
        );

        // assert
        result.when(
          success: (_) => fail('Should have failed'),
          failure: (e) => expect(e, tException),
        );
        verify(
          mockedRepo.login(request: tLoginRequest, remembered: false),
        ).called(1);
      },
    );

    test(
      'Failure Test Case 2: Should propagate different exception types from repository',
      () async {
        // arrange
        final tException = ServerException(
          message: 'Server error',
          statusCode: 500,
        );
        when(
          mockedRepo.login(request: tLoginRequest, remembered: false),
        ).thenAnswer((_) async => BaseResponse.failure(tException));

        // act
        final result = await loginUseCase.call(
          request: tLoginRequest,
          isRemembered: false,
        );

        // assert
        result.when(
          success: (_) => fail('Should have failed'),
          failure: (e) {
            expect(e, tException);
            expect(e.message, 'Server error');
            expect((e as ServerException).statusCode, 500);
          },
        );
      },
    );

    test(
      'Failure Test Case 3: Should handle login with different email and password combinations',
      () async {
        // arrange
        const tDifferentRequest = LoginRequestModel(
          email: 'another@example.com',
          password: 'differentPassword',
        );
        const tDifferentResponse = LoginResponseModel(
          message: 'Welcome back',
          token: 'different_token_456',
        );
        when(
          mockedRepo.login(request: tDifferentRequest, remembered: false),
        ).thenAnswer(
          (_) async => const BaseResponse.success(tDifferentResponse),
        );

        // act
        final result = await loginUseCase.call(
          request: tDifferentRequest,
          isRemembered: false,
        );

        // assert
        expect(result, const BaseResponse.success(tDifferentResponse));
        verify(
          mockedRepo.login(request: tDifferentRequest, remembered: false),
        ).called(1);
      },
    );

    test('should correctly map isRemembered to remembered parameter', () async {
      // arrange
      when(
        mockedRepo.login(request: tLoginRequest, remembered: true),
      ).thenAnswer((_) async => const BaseResponse.success(tLoginResponse));

      // act
      await loginUseCase.call(request: tLoginRequest, isRemembered: true);

      // assert
      verify(
        mockedRepo.login(request: tLoginRequest, remembered: true),
      ).called(1);
      verifyNever(mockedRepo.login(request: tLoginRequest, remembered: false));
    });
    // ------------------------------ END OF TEST CASES ------------------------------ //
  });
}
