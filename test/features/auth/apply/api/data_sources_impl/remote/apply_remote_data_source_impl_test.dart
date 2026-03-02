import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/auth/apply/api/api_clients/apply_api_client.dart';
import 'package:tracking_app/features/auth/apply/api/data_sources_impl/remote/apply_remote_data_source_impl.dart';
import 'package:tracking_app/features/auth/apply/data/datasources/remote/apply_remote_data_source.dart';
import 'package:tracking_app/features/auth/apply/data/models/request/apply_request_model/apply_request_model.dart';
import 'package:tracking_app/features/auth/apply/data/models/response/apply_response_model/apply_response_model.dart';
import 'package:tracking_app/features/auth/apply/data/models/response/driver_model/driver_model.dart';

import 'apply_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApplyApiClient])
void main() {
  Future<File> createTempFile(String name, [List<int>? bytes]) async {
    final dir = await Directory.systemTemp.createTemp('apply_test_');
    final file = File('${dir.path}/$name');
    await file.writeAsBytes(bytes ?? [1, 2, 3, 4]);
    return file;
  }

  group('apply remote data source impl', () {
    late MockApplyApiClient mockApplyApiClient;
    late ApplyRemoteDataSource applyRemoteDataSourceImpl;
    late ApplyRequestModel testApplyRequestModel;
    late ApplyResponseModel testApplyResponseModel;
    setUp(() async {
      mockApplyApiClient = MockApplyApiClient();
      applyRemoteDataSourceImpl = ApplyRemoteDataSourceImpl(mockApplyApiClient);
      testApplyRequestModel = ApplyRequestModel(
        country: 'country',
        firstName: 'firstName',
        lastName: 'lastName',
        vehicleType: 'vehicleType',
        vehicleNumber: 'vehicleNumber',
        vehicleLicense: await createTempFile('vehicleLicense.png'),
        nID: 'nID',
        nIDImg: await createTempFile('nIDImg.png'),
        email: 'email',
        password: 'password',
        rePassword: 'rePassword',
        gender: 'gender',
        phone: 'phone',
      );
      testApplyResponseModel = ApplyResponseModel(
        message: 'message',
        token: 'token',
        driver: DriverModel(
          id: 'id',
          firstName: 'firstName',
          lastName: 'lastName',
          vehicleType: 'vehicleType',
          vehicleNumber: 'vehicleNumber',
          vehicleLicense: 'vehicleLicense.png',
          nid: 'nid',
          nidImg: 'nIDImg.png',
          email: 'email',
          gender: 'gender',
          phone: 'phone',
          country: 'country',
          photo: 'photo',
          role: 'role',
          createdAt: DateTime(2026),
        ),
      );
    });

    tearDown(() async {
      if (testApplyRequestModel.vehicleLicense.existsSync()) {
        await testApplyRequestModel.vehicleLicense.delete();
      }
      if (testApplyRequestModel.nIDImg.existsSync()) {
        await testApplyRequestModel.nIDImg.delete();
      }
    });
    test('success case', () async {
      when(
        mockApplyApiClient.applyDriver(
          country: anyNamed('country'),
          firstName: anyNamed('firstName'),
          lastName: anyNamed('lastName'),
          vehicleType: anyNamed('vehicleType'),
          vehicleNumber: anyNamed('vehicleNumber'),
          vehicleLicense: anyNamed('vehicleLicense'),
          nID: anyNamed('nID'),
          nIDImg: anyNamed('nIDImg'),
          email: anyNamed('email'),
          password: anyNamed('password'),
          rePassword: anyNamed('rePassword'),
          gender: anyNamed('gender'),
          phone: anyNamed('phone'),
        ),
      ).thenAnswer((_) async => testApplyResponseModel);
      final result = await applyRemoteDataSourceImpl.applyDriver(
        testApplyRequestModel,
      );
      expect(result, isA<BaseResponse<ApplyResponseModel>>());
      result as Success<ApplyResponseModel>;
      expect(result.data, testApplyResponseModel);
      expect(result.data.message, 'message');
      expect(result.data.driver.vehicleLicense, 'vehicleLicense.png');
    });

    test('failure case', () async {
      when(
        mockApplyApiClient.applyDriver(
          country: anyNamed('country'),
          firstName: anyNamed('firstName'),
          lastName: anyNamed('lastName'),
          vehicleType: anyNamed('vehicleType'),
          vehicleNumber: anyNamed('vehicleNumber'),
          vehicleLicense: anyNamed('vehicleLicense'),
          nID: anyNamed('nID'),
          nIDImg: anyNamed('nIDImg'),
          email: anyNamed('email'),
          password: anyNamed('password'),
          rePassword: anyNamed('rePassword'),
          gender: anyNamed('gender'),
          phone: anyNamed('phone'),
        ),
      ).thenAnswer(
        (_) async => throw DioException(
          type: DioExceptionType.connectionError,
          message: 'Connection Error',
          requestOptions: RequestOptions(),
        ),
      );
      final result = await applyRemoteDataSourceImpl.applyDriver(
        testApplyRequestModel,
      );
      expect(result, isA<BaseResponse<ApplyResponseModel>>());
      result as Failure<ApplyResponseModel>;
      expect(result.exception.message, 'Connection Error');
    });
  });
}
