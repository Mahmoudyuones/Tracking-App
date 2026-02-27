import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/config/base_state/base_state.dart';
import 'package:tracking_app/config/exception/unknown_exception.dart';
import 'package:tracking_app/features/my_profile/domain/entities/driver_entity.dart';
import 'package:tracking_app/features/my_profile/domain/entities/driver_response_entity.dart';
import 'package:tracking_app/features/my_profile/domain/usecases/get_driver_profile_date_usecase.dart';
import 'package:tracking_app/features/my_profile/presentation/view_model/my_profile_cubit.dart';
import 'package:tracking_app/features/my_profile/presentation/view_model/my_profile_events.dart';
import 'package:tracking_app/features/my_profile/presentation/view_model/my_profile_state.dart';
import 'package:tracking_app/features/my_profile/presentation/view_model/my_profile_ui_events.dart';

import 'my_profile_cubit_test.mocks.dart';

@GenerateMocks([GetDriverProfileDateUsecase])
Future<void> main() async {
  late MyProfileCubit cubit;
  late MockGetDriverProfileDateUsecase mockGetDriverProfileDateUsecase;
  late List<MyProfileUiEvent> emittedUiEvents;

  const mockDriver = DriverEntity(
    firstName: 'John',
    lastName: 'Doe',
    vehicleType: 'Truck',
    vehicleNumber: 'ABC-1234',
    email: 'john.doe@example.com',
    phone: '+1234567890',
    photo: 'https://example.com/photo.jpg',
  );

  const mockDriverResponseEntity = DriverResponseEntity(driver: mockDriver);

  setUp(() {
    mockGetDriverProfileDateUsecase = MockGetDriverProfileDateUsecase();
    cubit = MyProfileCubit(mockGetDriverProfileDateUsecase);

    emittedUiEvents = [];
    cubit.uiEventStream.listen((event) {
      emittedUiEvents.add(event);
    });
  });

  tearDown(() {
    emittedUiEvents.clear();
    cubit.close();
  });

  group('initial state', () {
    test(
      'myProfileState should have no data, no error, and no isEmpty flag',
      () {
        expect(cubit.state.myProfileState.data, isNull);
        expect(cubit.state.myProfileState.errorMessage, isNull);
        expect(cubit.state.myProfileState.isEmpty, isNull);
      },
    );
  });

  group('onEvent — GetDriverProfileDateEvent — success', () {
    blocTest<MyProfileCubit, MyProfileState>(
      'emits state with driver data when usecase returns success',
      build: () {
        when(mockGetDriverProfileDateUsecase.call()).thenAnswer(
          (_) async => const BaseResponse.success(mockDriverResponseEntity),
        );
        return cubit;
      },
      act: (cubit) async {
        cubit.onEvent(GetDriverProfileDataEvent());
      },
      verify: (_) {
        verify(mockGetDriverProfileDateUsecase.call()).called(1);

        expect(
          cubit.state.myProfileState,
          equals(
            const BaseState<DriverResponseEntity>(
              data: mockDriverResponseEntity,
            ),
          ),
        );
      },
    );

    blocTest<MyProfileCubit, MyProfileState>(
      'emits [LoadingUiEvent, SuccessUiEvent] on success',
      build: () {
        when(mockGetDriverProfileDateUsecase.call()).thenAnswer(
          (_) async => const BaseResponse.success(mockDriverResponseEntity),
        );
        return cubit;
      },
      act: (cubit) async {
        cubit.onEvent(GetDriverProfileDataEvent());
      },
      verify: (_) {
        expect(emittedUiEvents.length, 2);
        expect(emittedUiEvents[0], isA<LoadingUiEvent>());
        expect(emittedUiEvents[1], isA<SuccessUiEvent>());

        final successEvent = emittedUiEvents[1] as SuccessUiEvent;
        expect(
          successEvent.driverResponseEntity,
          equals(mockDriverResponseEntity),
        );
      },
    );

    blocTest<MyProfileCubit, MyProfileState>(
      'SuccessUiEvent carries the correct DriverResponseEntity',
      build: () {
        when(mockGetDriverProfileDateUsecase.call()).thenAnswer(
          (_) async => const BaseResponse.success(mockDriverResponseEntity),
        );
        return cubit;
      },
      act: (cubit) async {
        cubit.onEvent(GetDriverProfileDataEvent());
      },
      verify: (_) {
        final successEvent = emittedUiEvents.whereType<SuccessUiEvent>().first;
        expect(
          successEvent.driverResponseEntity.driver.firstName,
          equals('John'),
        );
        expect(
          successEvent.driverResponseEntity.driver.email,
          equals('john.doe@example.com'),
        );
      },
    );
  });

  group('onEvent — GetDriverProfileDateEvent — failure', () {
    blocTest<MyProfileCubit, MyProfileState>(
      'emits state with errorMessage when usecase returns failure',
      build: () {
        when(mockGetDriverProfileDateUsecase.call()).thenAnswer(
          (_) async => BaseResponse.failure(
            UnknownException(message: 'Something went wrong'),
          ),
        );
        return cubit;
      },
      act: (cubit) async {
        cubit.onEvent(GetDriverProfileDataEvent());
      },
      verify: (_) {
        verify(mockGetDriverProfileDateUsecase.call()).called(1);

        expect(cubit.state.myProfileState.data, isNull);
        expect(cubit.state.myProfileState.errorMessage, isNotEmpty);
      },
    );

    blocTest<MyProfileCubit, MyProfileState>(
      'emits [LoadingUiEvent, ErrorUiEvent] on failure',
      build: () {
        when(mockGetDriverProfileDateUsecase.call()).thenAnswer(
          (_) async =>
              BaseResponse.failure(UnknownException(message: 'Network error')),
        );
        return cubit;
      },
      act: (cubit) async {
        cubit.onEvent(GetDriverProfileDataEvent());
      },
      verify: (_) {
        expect(emittedUiEvents.length, 2);
        expect(emittedUiEvents[0], isA<LoadingUiEvent>());
        expect(emittedUiEvents[1], isA<ErrorUiEvent>());
      },
    );

    blocTest<MyProfileCubit, MyProfileState>(
      'ErrorUiEvent contains the correct error message',
      build: () {
        when(mockGetDriverProfileDateUsecase.call()).thenAnswer(
          (_) async =>
              BaseResponse.failure(UnknownException(message: 'Network error')),
        );
        return cubit;
      },
      act: (cubit) async {
        cubit.onEvent(GetDriverProfileDataEvent());
      },
      verify: (_) {
        final errorEvent = emittedUiEvents.whereType<ErrorUiEvent>().first;
        expect(errorEvent.message, isNotEmpty);
      },
    );
  });

  group('onEvent — multiple calls', () {
    blocTest<MyProfileCubit, MyProfileState>(
      'calls usecase once per onEvent invocation',
      build: () {
        when(mockGetDriverProfileDateUsecase.call()).thenAnswer(
          (_) async => const BaseResponse.success(mockDriverResponseEntity),
        );
        return cubit;
      },
      act: (cubit) async {
        cubit.onEvent(GetDriverProfileDataEvent());
        cubit.onEvent(GetDriverProfileDataEvent());
      },
      verify: (_) {
        verify(mockGetDriverProfileDateUsecase.call()).called(2);
      },
    );
  });

  group('uiEventStream', () {
    test('should not be null', () {
      expect(cubit.uiEventStream, isNotNull);
    });

    test('should be a broadcast stream — supports multiple listeners', () {
      final sub1 = cubit.uiEventStream.listen((_) {});
      final sub2 = cubit.uiEventStream.listen((_) {});

      expect(sub1, isNotNull);
      expect(sub2, isNotNull);

      sub1.cancel();
      sub2.cancel();
    });
  });
}
