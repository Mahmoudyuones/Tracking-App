import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/config/exception/app_exception.dart';
import 'package:tracking_app/config/exception/server_exception.dart';
import 'package:tracking_app/features/my_profile/api/api_client/my_profile_api_client.dart';
import 'package:tracking_app/features/my_profile/api/datasources_impl/my_profile_remote_data_source_impl.dart';
import 'package:tracking_app/features/my_profile/data/models/driver_model.dart';
import 'package:tracking_app/features/my_profile/data/models/driver_response_model.dart';

import 'my_profile_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([MyProfileApiClient])
void main() {
  late MyProfileRemoteDataSourceImpl myProfileRemoteDataSourceImpl;
  late MockMyProfileApiClient mockMyProfileApiClient;

  setUp(() {
    mockMyProfileApiClient = MockMyProfileApiClient();
    myProfileRemoteDataSourceImpl = MyProfileRemoteDataSourceImpl(
      mockMyProfileApiClient,
    );
  });

  group('getMyProfileData', () {
    final tDriverResponseModel = DriverResponseModel(
      message: 'Success',
      driver: DriverModel(
        firstName: 'John',
        lastName: 'Doe',
        vehicleType: 'Sedan',
        vehicleNumber: 'ABC123',
        email: 'john.doe@example.com',
        phone: '+1234567890',
        photo: 'https://example.com/photo.jpg',
      ),
    );

    test(
      'should return BaseResponse.success with DriverResponseModel when API call is successful',
      () async {
        when(
          mockMyProfileApiClient.getMyProfileData(),
        ).thenAnswer((_) async => tDriverResponseModel);

        final result = await myProfileRemoteDataSourceImpl.getMyProfileData();

        expect(result, isA<Success<DriverResponseModel>>());
        result.when(
          success: (data) {
            expect(data, equals(tDriverResponseModel));
            expect(data.message, equals('Success'));
            expect(data.driver?.firstName, equals('John'));
          },
          failure: (_) => fail('Expected success but got failure'),
        );
        verify(mockMyProfileApiClient.getMyProfileData()).called(1);
        verifyNoMoreInteractions(mockMyProfileApiClient);
      },
    );

    test(
      'should return BaseResponse.failure when API call throws an exception',
      () async {
        when(
          mockMyProfileApiClient.getMyProfileData(),
        ).thenThrow(Exception('Network error'));

        final result = await myProfileRemoteDataSourceImpl.getMyProfileData();

        expect(result, isA<Failure<DriverResponseModel>>());
        result.when(
          success: (_) => fail('Expected failure but got success'),
          failure: (exception) {
            expect(exception, isA<AppException>());
          },
        );
        verify(mockMyProfileApiClient.getMyProfileData()).called(1);
        verifyNoMoreInteractions(mockMyProfileApiClient);
      },
    );

    test(
      'should return BaseResponse.failure when API call throws a server exception',
      () async {
        final serverException = ServerException(
          message: 'Server error',
          statusCode: 500,
        );
        when(
          mockMyProfileApiClient.getMyProfileData(),
        ).thenThrow(serverException);

        final result = await myProfileRemoteDataSourceImpl.getMyProfileData();

        expect(result, isA<Failure<DriverResponseModel>>());
        result.when(
          success: (_) => fail('Expected failure but got success'),
          failure: (exception) {
            expect(exception, isA<AppException>());
          },
        );
        verify(mockMyProfileApiClient.getMyProfileData()).called(1);
        verifyNoMoreInteractions(mockMyProfileApiClient);
      },
    );

    test(
      'should call MyProfileApiClient.getMyProfileData exactly once',
      () async {
        when(
          mockMyProfileApiClient.getMyProfileData(),
        ).thenAnswer((_) async => tDriverResponseModel);

        await myProfileRemoteDataSourceImpl.getMyProfileData();

        verify(mockMyProfileApiClient.getMyProfileData()).called(1);
      },
    );
  });

  group('logout', () {
    test(
      'should return BaseResponse.success<void> when API call is successful',
      () async {
        when(mockMyProfileApiClient.logout()).thenAnswer((_) async {});

        final result = await myProfileRemoteDataSourceImpl.logout();

        expect(result, isA<Success<void>>());
        verify(mockMyProfileApiClient.logout()).called(1);
        verifyNoMoreInteractions(mockMyProfileApiClient);
      },
    );

    test(
      'should return BaseResponse.failure when API call throws a generic exception',
      () async {
        when(
          mockMyProfileApiClient.logout(),
        ).thenThrow(Exception('Network error'));

        final result = await myProfileRemoteDataSourceImpl.logout();

        expect(result, isA<Failure<void>>());
        result.when(
          success: (_) => fail('Expected failure but got success'),
          failure: (exception) {
            expect(exception, isA<AppException>());
          },
        );
        verify(mockMyProfileApiClient.logout()).called(1);
        verifyNoMoreInteractions(mockMyProfileApiClient);
      },
    );

    test(
      'should return BaseResponse.failure when API call throws a ServerException',
      () async {
        final serverException = ServerException(
          message: 'Unauthorized',
          statusCode: 401,
        );
        when(mockMyProfileApiClient.logout()).thenThrow(serverException);

        final result = await myProfileRemoteDataSourceImpl.logout();

        expect(result, isA<Failure<void>>());
        result.when(
          success: (_) => fail('Expected failure but got success'),
          failure: (exception) {
            expect(exception, isA<AppException>());
          },
        );
        verify(mockMyProfileApiClient.logout()).called(1);
        verifyNoMoreInteractions(mockMyProfileApiClient);
      },
    );

    test('should call MyProfileApiClient.logout exactly once', () async {
      when(mockMyProfileApiClient.logout()).thenAnswer((_) async {});

      await myProfileRemoteDataSourceImpl.logout();

      verify(mockMyProfileApiClient.logout()).called(1);
    });
  });
}
