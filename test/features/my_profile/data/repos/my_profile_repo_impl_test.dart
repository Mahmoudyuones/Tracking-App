import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/config/exception/app_exception.dart';
import 'package:tracking_app/config/exception/server_exception.dart';
import 'package:tracking_app/features/my_profile/api/datasources_impl/my_profile_remote_data_source_impl.dart';
import 'package:tracking_app/features/my_profile/data/models/driver_model.dart';
import 'package:tracking_app/features/my_profile/data/models/driver_response_model.dart';
import 'package:tracking_app/features/my_profile/data/repos/my_profile_repo_impl.dart';
import 'package:tracking_app/features/my_profile/domain/entities/driver_response_entity.dart';

import 'my_profile_repo_impl_test.mocks.dart';

@GenerateMocks([MyProfileRemoteDataSourceImpl])
void main() {
  late MyProfileRepoImpl myProfileRepoImpl;
  late MockMyProfileRemoteDataSourceImpl mockMyProfileRemoteDataSourceImpl;

  setUp(() {
    mockMyProfileRemoteDataSourceImpl = MockMyProfileRemoteDataSourceImpl();
    myProfileRepoImpl = MyProfileRepoImpl(mockMyProfileRemoteDataSourceImpl);
  });

  group('getMyProfileData', () {
    final tDriverModel = DriverModel(
      firstName: 'John',
      lastName: 'Doe',
      vehicleType: 'Sedan',
      vehicleNumber: 'ABC123',
      email: 'john.doe@example.com',
      phone: '+1234567890',
      photo: 'https://example.com/photo.jpg',
    );

    final tDriverResponseModel = DriverResponseModel(
      message: 'Success',
      driver: tDriverModel,
    );

    final tAppException = ServerException(
      message: 'Server error',
      statusCode: 500,
    );

    test(
      'should return BaseResponse.success with DriverResponseEntity when remote data source returns success',
      () async {
        when(
          mockMyProfileRemoteDataSourceImpl.getMyProfileData(),
        ).thenAnswer((_) async => BaseResponse.success(tDriverResponseModel));

        final result = await myProfileRepoImpl.getMyProfileData();

        expect(result, isA<Success<DriverResponseEntity>>());
        result.when(
          success: (entity) {
            expect(entity, isA<DriverResponseEntity>());
            expect(entity.driver.firstName, equals('John'));
            expect(entity.driver.lastName, equals('Doe'));
            expect(entity.driver.vehicleType, equals('Sedan'));
            expect(entity.driver.vehicleNumber, equals('ABC123'));
            expect(entity.driver.email, equals('john.doe@example.com'));
            expect(entity.driver.phone, equals('+1234567890'));
            expect(
              entity.driver.photo,
              equals('https://example.com/photo.jpg'),
            );
          },
          failure: (_) => fail('Expected success but got failure'),
        );
        verify(mockMyProfileRemoteDataSourceImpl.getMyProfileData()).called(1);
        verifyNoMoreInteractions(mockMyProfileRemoteDataSourceImpl);
      },
    );

    test(
      'should return BaseResponse.failure when remote data source returns failure',
      () async {
        when(mockMyProfileRemoteDataSourceImpl.getMyProfileData()).thenAnswer(
          (_) async => BaseResponse<DriverResponseModel>.failure(tAppException),
        );

        final result = await myProfileRepoImpl.getMyProfileData();

        expect(result, isA<Failure<DriverResponseEntity>>());
        result.when(
          success: (_) => fail('Expected failure but got success'),
          failure: (exception) {
            expect(exception, isA<AppException>());
            expect(exception, equals(tAppException));
          },
        );
        verify(mockMyProfileRemoteDataSourceImpl.getMyProfileData()).called(1);
        verifyNoMoreInteractions(mockMyProfileRemoteDataSourceImpl);
      },
    );

    test(
      'should call remote data source getMyProfileData exactly once',
      () async {
        when(
          mockMyProfileRemoteDataSourceImpl.getMyProfileData(),
        ).thenAnswer((_) async => BaseResponse.success(tDriverResponseModel));

        await myProfileRepoImpl.getMyProfileData();

        verify(mockMyProfileRemoteDataSourceImpl.getMyProfileData()).called(1);
      },
    );

    test(
      'should transform DriverResponseModel to DriverResponseEntity correctly',
      () async {
        when(
          mockMyProfileRemoteDataSourceImpl.getMyProfileData(),
        ).thenAnswer((_) async => BaseResponse.success(tDriverResponseModel));

        final result = await myProfileRepoImpl.getMyProfileData();

        result.when(
          success: (entity) {
            expect(entity.driver.firstName, equals(tDriverModel.firstName));
            expect(entity.driver.lastName, equals(tDriverModel.lastName));
            expect(entity.driver.vehicleType, equals(tDriverModel.vehicleType));
            expect(
              entity.driver.vehicleNumber,
              equals(tDriverModel.vehicleNumber),
            );
            expect(entity.driver.email, equals(tDriverModel.email));
            expect(entity.driver.phone, equals(tDriverModel.phone));
            expect(entity.driver.photo, equals(tDriverModel.photo));
          },
          failure: (_) => fail('Expected success but got failure'),
        );
      },
    );
  });

  group('logout', () {
    final tAppException = ServerException(
      message: 'Server error',
      statusCode: 500,
    );

    test(
      'should return BaseResponse.success<void> when remote data source returns success',
      () async {
        when(
          mockMyProfileRemoteDataSourceImpl.logout(),
        ).thenAnswer((_) async => const BaseResponse<void>.success(null));

        final result = await myProfileRepoImpl.logout();

        expect(result, isA<Success<void>>());
        result.when(
          success: (_) {},
          failure: (_) => fail('Expected success but got failure'),
        );
        verify(mockMyProfileRemoteDataSourceImpl.logout()).called(1);
        verifyNoMoreInteractions(mockMyProfileRemoteDataSourceImpl);
      },
    );

    test(
      'should return BaseResponse.failure when remote data source returns failure',
      () async {
        when(
          mockMyProfileRemoteDataSourceImpl.logout(),
        ).thenAnswer((_) async => BaseResponse<void>.failure(tAppException));

        final result = await myProfileRepoImpl.logout();

        expect(result, isA<Failure<void>>());
        result.when(
          success: (_) => fail('Expected failure but got success'),
          failure: (exception) {
            expect(exception, isA<AppException>());
            expect(exception, equals(tAppException));
          },
        );
        verify(mockMyProfileRemoteDataSourceImpl.logout()).called(1);
        verifyNoMoreInteractions(mockMyProfileRemoteDataSourceImpl);
      },
    );

    test('should call remote data source logout exactly once', () async {
      when(
        mockMyProfileRemoteDataSourceImpl.logout(),
      ).thenAnswer((_) async => const BaseResponse<void>.success(null));

      await myProfileRepoImpl.logout();

      verify(mockMyProfileRemoteDataSourceImpl.logout()).called(1);
    });
  });
}
