import 'dart:io';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/config/exception/auth_exception.dart';
import 'package:tracking_app/features/auth/apply/data/datasources/local/apply_local_data_source.dart';
import 'package:tracking_app/features/auth/apply/data/datasources/remote/apply_remote_data_source.dart';
import 'package:tracking_app/features/auth/apply/data/models/response/apply_response_model/apply_response_model.dart';
import 'package:tracking_app/features/auth/apply/data/models/response/driver_model/driver_model.dart';
import 'package:tracking_app/features/auth/apply/data/repositories/apply_repository_impl.dart';
import 'package:tracking_app/features/auth/apply/domain/entities/request/apply_request_entity.dart';
import 'package:tracking_app/features/auth/apply/domain/repositories/apply_repository.dart';

import 'apply_repository_impl_test.mocks.dart';

@GenerateMocks([ApplyRemoteDataSource, ApplyLocalDataSource])
void main() {
  late MockApplyRemoteDataSource mockApplyRemoteDataSource;
  late MockApplyLocalDataSource mockApplyLocalDataSource;
  late ApplyRepository applyRepositoryImpl;
  final ApplyResponseModel applyResponseModel = ApplyResponseModel(
    message: 'message',
    driver: DriverModel(
      country: 'country',
      firstName: 'firstName',
      lastName: 'lastName',
      vehicleType: 'vehicleType',
      vehicleNumber: 'vehicleNumber',
      vehicleLicense: 'vehicleLicense',
      nid: 'nid',
      nidImg: 'nidImg',
      email: 'email',
      gender: 'gender',
      phone: 'phone',
      photo: 'photo',
      role: 'role',
      id: 'id',
      createdAt: DateTime.now(),
    ),
    token: 'token',
  );
  final ApplyRequestEntity applyRequestEntity = ApplyRequestEntity(
    country: 'country',
    firstName: 'firstName',
    lastName: 'lastName',
    vehicleType: 'vehicleType',
    vehicleNumber: 'vehicleNumber',
    vehicleLicense: File(''),
    nID: 'nID',
    nIDImg: File(''),
    email: 'email',
    password: 'password',
    rePassword: 'rePassword',
    gender: 'gender',
    phone: 'phone',
  );
  setUp(() {
    mockApplyRemoteDataSource = MockApplyRemoteDataSource();
    mockApplyLocalDataSource = MockApplyLocalDataSource();
    applyRepositoryImpl = ApplyRepositoryImpl(
      mockApplyRemoteDataSource,
      mockApplyLocalDataSource,
    );
  });

  group('apply repository', () {
    test('should return success when remote and local are success', () async {
      when(mockApplyRemoteDataSource.applyDriver(any)).thenAnswer(
        (_) async =>
            BaseResponse<ApplyResponseModel>.success(applyResponseModel),
      );
      when(
        mockApplyLocalDataSource.saveToken(any),
      ).thenAnswer((_) async => const BaseResponse<void>.success(null));

      final result = await applyRepositoryImpl.apply(applyRequestEntity);
      expect(result, isA<Success<String>>());
    });
    test('should return failure when remote is failure', () async {
      when(mockApplyRemoteDataSource.applyDriver(any)).thenAnswer(
        (_) async => BaseResponse<ApplyResponseModel>.failure(
          AuthException(message: 'Exception'),
        ),
      );
      when(
        mockApplyLocalDataSource.saveToken(any),
      ).thenAnswer((_) async => const BaseResponse<void>.success(null));

      final result = await applyRepositoryImpl.apply(applyRequestEntity);
      expect(result, isA<Failure<String>>());
      verify(mockApplyRemoteDataSource.applyDriver(any)).called(1);
      verifyNever(mockApplyLocalDataSource.saveToken(any)).called(0);
    });
    test('should return failure when local is failure', () async {
      when(mockApplyRemoteDataSource.applyDriver(any)).thenAnswer(
        (_) async =>
            BaseResponse<ApplyResponseModel>.success(applyResponseModel),
      );
      when(mockApplyLocalDataSource.saveToken(any)).thenAnswer(
        (_) async =>
            BaseResponse<void>.failure(AuthException(message: 'Exception')),
      );

      final result = await applyRepositoryImpl.apply(applyRequestEntity);
      expect(result, isA<Failure<String>>());
      verify(mockApplyRemoteDataSource.applyDriver(any)).called(1);
      verify(mockApplyLocalDataSource.saveToken(any)).called(1);
    });
    test('should return failure when remote and local are failure', () async {
      when(mockApplyRemoteDataSource.applyDriver(any)).thenAnswer(
        (_) async => BaseResponse<ApplyResponseModel>.failure(
          AuthException(message: 'Exception'),
        ),
      );
      when(mockApplyLocalDataSource.saveToken(any)).thenAnswer(
        (_) async =>
            BaseResponse<void>.failure(AuthException(message: 'Exception')),
      );

      final result = await applyRepositoryImpl.apply(applyRequestEntity);
      expect(result, isA<Failure<String>>());
      verify(mockApplyRemoteDataSource.applyDriver(any)).called(1);
      verifyNever(mockApplyLocalDataSource.saveToken(any)).called(0);
    });
  });
}
