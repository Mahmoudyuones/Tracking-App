import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/config/exception/network_exception.dart';
import 'package:tracking_app/config/exception/server_exception.dart';
import 'package:tracking_app/features/edit_profile/data/data_sources/edit_profile_data_source.dart';
import 'package:tracking_app/features/edit_profile/data/models/request/edit_profile_request.dart';
import 'package:tracking_app/features/edit_profile/data/models/response/edit_profile_response_model.dart';
import 'package:tracking_app/features/edit_profile/data/models/response/upload_photo_response.dart';
import 'package:tracking_app/features/edit_profile/data/repositories/edit_profile_repository_impl.dart';
import 'package:tracking_app/features/edit_profile/data/models/response/driver.dart';
import 'dart:io';

import 'edit_profile_repository_impl_test.mocks.dart';

@GenerateMocks([EditProfileDataSource, File, Driver])
void main() {
  late EditProfileRepositoryImpl repository;
  late MockEditProfileDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockEditProfileDataSource();
    repository = EditProfileRepositoryImpl(mockDataSource);
  });

  group('EditProfileRepositoryImpl', () {
    const editProfileRequest = EditProfileRequest(
      firstName: 'John',
      lastName: 'Doe',
      phone: '123456789',
      email: 'john.doe@example.com',
    );

    final mockDriver = MockDriver();
    final editProfileResponse = EditProfileResponseModel(
      message: 'Success',
      driver: mockDriver,
    );

    final uploadPhotoResponse = UploadPhotoResponse('Success');

    test(
      'editProfile should return success BaseResponse<void> when data source returns success',
      () async {
        // Arrange
        when(
          mockDataSource.editProfile(any),
        ).thenAnswer((_) async => BaseResponse.success(editProfileResponse));

        // Act
        final result = await repository.editProfile(editProfileRequest);

        // Assert
        expect(result, isA<BaseResponse<void>>());
        result.when(
          success: (_) {},
          failure: (_) => fail('Expected success but got failure'),
        );
        verify(mockDataSource.editProfile(any)).called(1);
      },
    );

    test(
      'editProfile should return failure BaseResponse when data source returns failure',
      () async {
        // Arrange
        final exception = NetworkException(message: 'Network error');
        when(
          mockDataSource.editProfile(any),
        ).thenAnswer((_) async => BaseResponse.failure(exception));

        // Act
        final result = await repository.editProfile(editProfileRequest);

        // Assert
        result.when(
          success: (_) => fail('Expected failure but got success'),
          failure: (error) {
            expect(error, isA<NetworkException>());
            expect(error.message, 'Network error');
          },
        );
        verify(mockDataSource.editProfile(any)).called(1);
      },
    );

    test(
      'updateProfileImage should return success BaseResponse<void> when data source returns success',
      () async {
        // Arrange
        final mockFile = MockFile();
        when(
          mockDataSource.updateProfileImage(any),
        ).thenAnswer((_) async => BaseResponse.success(uploadPhotoResponse));

        // Act
        final result = await repository.updateProfileImage(mockFile);

        // Assert
        expect(result, isA<BaseResponse<void>>());
        result.when(
          success: (_) {},
          failure: (_) => fail('Expected success but got failure'),
        );
        verify(mockDataSource.updateProfileImage(any)).called(1);
      },
    );

    test(
      'updateProfileImage should return failure BaseResponse when data source returns failure',
      () async {
        // Arrange
        final mockFile = MockFile();
        final exception = ServerException(
          message: 'Server error',
          statusCode: 500,
        );
        when(
          mockDataSource.updateProfileImage(any),
        ).thenAnswer((_) async => BaseResponse.failure(exception));

        // Act
        final result = await repository.updateProfileImage(mockFile);

        // Assert
        result.when(
          success: (_) => fail('Expected failure but got success'),
          failure: (error) {
            expect(error, isA<ServerException>());
            expect((error as ServerException).statusCode, 500);
          },
        );
        verify(mockDataSource.updateProfileImage(any)).called(1);
      },
    );
  });
}
