import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/config/exception/app_exception.dart';
import 'package:tracking_app/config/exception/network_exception.dart';
import 'package:tracking_app/config/exception/server_exception.dart';
import 'package:tracking_app/features/edit_profile/api/api_client/edit_profile_api_client.dart';
import 'package:tracking_app/features/edit_profile/api/data_sources/edit_profile_data_source_impl.dart';
import 'package:tracking_app/features/edit_profile/data/models/request/edit_profile_request.dart';
import 'package:tracking_app/features/edit_profile/data/models/response/edit_profile_response_model.dart';
import 'package:tracking_app/features/edit_profile/data/models/response/upload_photo_response.dart';
import 'package:tracking_app/features/edit_profile/data/models/response/driver.dart';
import 'dart:io';

import 'edit_profile_data_source_impl_test.mocks.dart';

@GenerateMocks([EditProfileApiClient, File, Driver])
void main() {
  late EditProfileDataSourceImpl dataSource;
  late MockEditProfileApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockEditProfileApiClient();
    dataSource = EditProfileDataSourceImpl(mockApiClient);
  });

  group('EditProfileDataSourceImpl', () {
    const editProfileRequest = EditProfileRequest(
      firstName: 'John',
      lastName: 'Doe',
      phone: '123456789',
      email: 'john.doe@example.com',
    );

    final editProfileResponse = EditProfileResponseModel(
      message: 'Profile updated successfully',
      driver:
          MockDriver(), // Assuming Driver is part of the model and needs mocking or a fake
    );

    final uploadPhotoResponse = UploadPhotoResponse(
      'Photo uploaded successfully',
    );

    test(
      'editProfile should return success BaseResponse when api client returns EditProfileResponseModel',
      () async {
        // Arrange
        when(
          mockApiClient.editProfile(any),
        ).thenAnswer((_) async => editProfileResponse);

        // Act
        final result = await dataSource.editProfile(editProfileRequest);

        // Assert
        expect(result, isA<BaseResponse<EditProfileResponseModel>>());
        result.when(
          success: (data) {
            expect(data.message, 'Profile updated successfully');
          },
          failure: (_) => fail('Expected success but got failure'),
        );
        verify(mockApiClient.editProfile(any)).called(1);
      },
    );

    test(
      'editProfile should return failure BaseResponse when api client throws NetworkException',
      () async {
        // Arrange
        final exception = NetworkException(message: 'No internet');
        when(mockApiClient.editProfile(any)).thenThrow(exception);

        // Act
        final result = await dataSource.editProfile(editProfileRequest);

        // Assert
        result.when(
          success: (_) => fail('Expected failure but got success'),
          failure: (error) {
            expect(error, isA<AppException>());
            expect(error.message, 'No internet');
          },
        );
      },
    );

    test(
      'updateProfileImage should return success BaseResponse when api client returns UploadPhotoResponse',
      () async {
        // Arrange
        final mockFile = MockFile();
        when(
          mockApiClient.updateProfileImage(any),
        ).thenAnswer((_) async => uploadPhotoResponse);

        // Act
        final result = await dataSource.updateProfileImage(mockFile);

        // Assert
        expect(result, isA<BaseResponse<UploadPhotoResponse>>());
        result.when(
          success: (data) {
            expect(data.message, 'Photo uploaded successfully');
          },
          failure: (_) => fail('Expected success but got failure'),
        );
        verify(mockApiClient.updateProfileImage(any)).called(1);
      },
    );

    test(
      'updateProfileImage should return failure BaseResponse when api client throws ServerException',
      () async {
        // Arrange
        final mockFile = MockFile();
        final exception = ServerException(
          message: 'Server error',
          statusCode: 500,
        );
        when(mockApiClient.updateProfileImage(any)).thenThrow(exception);

        // Act
        final result = await dataSource.updateProfileImage(mockFile);

        // Assert
        result.when(
          success: (_) => fail('Expected failure but got success'),
          failure: (error) {
            expect(error, isA<ServerException>());
            expect((error as ServerException).statusCode, 500);
          },
        );
      },
    );
  });
}
