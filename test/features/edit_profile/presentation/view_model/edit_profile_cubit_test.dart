import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/config/exception/unknown_exception.dart';
import 'package:tracking_app/features/edit_profile/domain/use_cases/edit_profile_use_case.dart';
import 'package:tracking_app/features/edit_profile/domain/use_cases/update_profile_image_use_case.dart';
import 'package:tracking_app/features/edit_profile/presentation/view_model/edit_profile_cubit.dart';
import 'package:tracking_app/features/edit_profile/presentation/view_model/edit_profile_intents.dart';
import 'package:tracking_app/features/edit_profile/presentation/view_model/edit_profile_states.dart';
import 'package:tracking_app/features/edit_profile/presentation/view_model/edit_profile_ui_intents.dart';
import 'package:tracking_app/features/my_profile/domain/entities/driver_entity.dart';

import 'edit_profile_cubit_test.mocks.dart';

@GenerateMocks([EditProfileUseCase, UpdateProfileImageUseCase])
void main() {
  late EditProfileCubit cubit;
  late MockEditProfileUseCase mockEditProfileUseCase;
  late MockUpdateProfileImageUseCase mockUpdateProfileImageUseCase;
  late List<EditProfileUiIntents> uiEvents;

  const mockDriver = DriverEntity(
    firstName: 'John',
    lastName: 'Doe',
    vehicleType: 'Truck',
    vehicleNumber: 'ABC-1234',
    email: 'john.doe@example.com',
    phone: '+201234567890',
    photo: 'https://example.com/photo.jpg',
  );

  setUp(() {
    mockEditProfileUseCase = MockEditProfileUseCase();
    mockUpdateProfileImageUseCase = MockUpdateProfileImageUseCase();
    cubit = EditProfileCubit(
      editProfileUseCase: mockEditProfileUseCase,
      updateProfileImageUseCase: mockUpdateProfileImageUseCase,
    );
    uiEvents = [];
    cubit.uiIntentsStream.listen(uiEvents.add);
  });

  void seed() => cubit.loadFromDriver(
    firstName: mockDriver.firstName,
    lastName: mockDriver.lastName,
    email: mockDriver.email,
    phone: mockDriver.phone,
    photoUrl: mockDriver.photo,
  );

  group('EditProfileCubit Tests', () {
    test('initial state is empty', () {
      expect(cubit.state.firstName, isEmpty);
      expect(cubit.state.isValidForm, isFalse);
    });

    test('loadFromDriver populates state and validates form', () {
      seed();
      expect(cubit.state.firstName, 'John');
      expect(cubit.state.isValidForm, isTrue);
    });

    group('Field Changes', () {
      blocTest<EditProfileCubit, EditProfileStates>(
        'updates fields in state correctly',
        build: () => cubit,
        act: (c) {
          c.doIntent(const FirstNameChangedIntent('Jane'));
          c.doIntent(const LastNameChangedIntent('Smith'));
          c.doIntent(const EmailChangedIntent('jane@test.com'));
          c.doIntent(const PhoneChangedIntent('+201111111111'));
        },
        expect: () => [
          isA<EditProfileStates>().having(
            (s) => s.firstName,
            'firstName',
            'Jane',
          ),
          isA<EditProfileStates>().having(
            (s) => s.lastName,
            'lastName',
            'Smith',
          ),
          isA<EditProfileStates>().having(
            (s) => s.email,
            'email',
            'jane@test.com',
          ),
          isA<EditProfileStates>().having(
            (s) => s.phone,
            'phone',
            '+201111111111',
          ),
        ],
      );
    });

    group('Form Validation', () {
      test('isValidForm is false when any field is invalid', () {
        seed();
        cubit.doIntent(const FirstNameChangedIntent(''));
        expect(cubit.state.isValidForm, isFalse);

        seed();
        cubit.doIntent(const EmailChangedIntent('invalid-email'));
        expect(cubit.state.isValidForm, isFalse);
      });
    });

    group('Actions (Submit & Photo)', () {
      blocTest<EditProfileCubit, EditProfileStates>(
        'UpdateProfileSubmitIntent — success emits correct UI intents',
        build: () {
          when(
            mockEditProfileUseCase.call(any),
          ).thenAnswer((_) async => const BaseResponse.success(null));
          return cubit;
        },
        act: (c) async {
          seed();
          c.doIntent(const FirstNameChangedIntent('Jane')); // Make state dirty
          c.doIntent(const UpdateProfileSubmitIntent());
          await Future.delayed(Duration.zero);
        },
        verify: (_) {
          expect(uiEvents.any((e) => e is ShowLoadingIntent), isTrue);
          expect(uiEvents.any((e) => e is UpdateProfileSuccessIntent), isTrue);
        },
      );

      blocTest<EditProfileCubit, EditProfileStates>(
        'UpdateProfilePhotoIntent — success emits correct UI intents',
        build: () {
          when(
            mockUpdateProfileImageUseCase.call(any),
          ).thenAnswer((_) async => const BaseResponse.success(null));
          return cubit;
        },
        act: (c) async {
          c.doIntent(UpdateProfilePhotoIntent(File('test.jpg')));
          await Future.delayed(Duration.zero);
        },
        verify: (_) {
          expect(uiEvents.any((e) => e is ShowPhotoLoadingIntent), isTrue);
          expect(uiEvents.any((e) => e is UpdatePhotoSuccessIntent), isTrue);
        },
      );

      blocTest<EditProfileCubit, EditProfileStates>(
        'handle failures correctly',
        build: () {
          when(mockEditProfileUseCase.call(any)).thenAnswer(
            (_) async =>
                BaseResponse.failure(UnknownException(message: 'Error')),
          );
          return cubit;
        },
        act: (c) async {
          c.doIntent(const UpdateProfileSubmitIntent());
          await Future.delayed(Duration.zero);
        },
        verify: (_) {
          expect(uiEvents.any((e) => e is ShowErrorIntent), isTrue);
        },
      );
    });
  });
}
