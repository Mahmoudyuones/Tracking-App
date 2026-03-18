import 'dart:io';
import 'package:test/test.dart';
import 'package:tracking_app/features/auth/apply/data/mappers/request/apply_request_mapper.dart';
import 'package:tracking_app/features/auth/apply/data/models/request/apply_request_model/apply_request_model.dart';
import 'package:tracking_app/features/auth/apply/domain/entities/request/apply_request_entity.dart';

void main() {
  late ApplyRequestEntity applyRequestEntity;
  test('apply request mapper ...', () {
    applyRequestEntity = ApplyRequestEntity(
      country: 'country',
      firstName: 'firstName',
      lastName: 'lastName',
      vehicleType: 'vehicleType',
      vehicleNumber: 'vehicleNumber',
      vehicleLicense: File('vehicleLicense'),
      nID: 'nID',
      nIDImg: File('nIDImg'),
      email: 'email',
      password: 'password',
      rePassword: 'rePassword',
      gender: 'gender',
      phone: 'phone',
    );
    final applyRequestModel = applyRequestEntity.toModel();
    expect(applyRequestModel, isA<ApplyRequestModel>());
    expect(applyRequestModel.country, applyRequestEntity.country);
    expect(applyRequestModel.firstName, applyRequestEntity.firstName);
    expect(applyRequestModel.lastName, applyRequestEntity.lastName);
    expect(applyRequestModel.vehicleType, applyRequestEntity.vehicleType);
    expect(applyRequestModel.vehicleNumber, applyRequestEntity.vehicleNumber);
    expect(applyRequestModel.vehicleLicense, applyRequestEntity.vehicleLicense);
    expect(applyRequestModel.nID, applyRequestEntity.nID);
    expect(applyRequestModel.nIDImg, applyRequestEntity.nIDImg);
    expect(applyRequestModel.email, applyRequestEntity.email);
    expect(applyRequestModel.password, applyRequestEntity.password);
    expect(applyRequestModel.rePassword, applyRequestEntity.rePassword);
    expect(applyRequestModel.gender, applyRequestEntity.gender);
    expect(applyRequestModel.phone, applyRequestEntity.phone);
  });
}
