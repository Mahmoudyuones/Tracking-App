import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/profile/api/client/profile_api_services.dart';
import 'package:tracking_app/features/profile/api/data_source/remote/profile_remote_data_source_impl.dart';
import 'package:tracking_app/features/profile/api/models/edit_profile/request/edit_vehicle_request.dart';
import 'package:tracking_app/features/profile/api/models/edit_profile/response/edit_profile_response.dart';
import 'package:tracking_app/features/profile/domain/entity/edit_profile_entity.dart';




import 'profile_remote_data_source_impl_test.mocks.dart';
@GenerateMocks([ProfileApiServices,EditProfileResponse])

void main() {
  late ProfileRemoteDataSourceImpl dataSource;
  late MockProfileApiServices mockProfileApiServices;

  setUp(() {
    mockProfileApiServices = MockProfileApiServices();
    dataSource = ProfileRemoteDataSourceImpl(mockProfileApiServices);
  });

  group('ProfileRemoteDataSourceImpl - editVehicle', () {

    final tRequest = EditVehicleRequest();


    final tResponseModel = MockEditProfileResponse();
    const EditProfileEntity tEntity =EditProfileEntity();

    test('should return BaseResponse<EditProfileEntity> when the API call is successful', () async {

      when(mockProfileApiServices.editVehicle(any))
          .thenAnswer((_) async => tResponseModel);


      when(tResponseModel.toEntity()).thenReturn(tEntity);

      // act
      final result = await dataSource.editVehicle(tRequest);

      // assert

      verify(mockProfileApiServices.editVehicle(await tRequest.toFormDataMap())).called(1);


      expect(result, isA<BaseResponse<EditProfileEntity>>());


    });

    test('should rethrow or return error BaseResponse when API call fails', () async {
      // arrange

      when(mockProfileApiServices.editVehicle(any))
          .thenThrow(Exception('API Error'));

      // act



      // assert
      verify(mockProfileApiServices.editVehicle(await tRequest.toFormDataMap())).called(1);

    });
  });
}

