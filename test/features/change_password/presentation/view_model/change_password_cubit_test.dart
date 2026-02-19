import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/config/exception/unknown_exception.dart';
import 'package:tracking_app/features/change_password/domain/entities/change_password_request_entity.dart';
import 'package:tracking_app/features/change_password/domain/use_cases/change_password_use_case.dart';
import 'package:tracking_app/features/change_password/presentation/view_model/change_password_cubit.dart';
import 'package:tracking_app/features/change_password/presentation/view_model/change_password_intents.dart';
import 'package:tracking_app/features/change_password/presentation/view_model/change_password_states.dart';
import 'package:tracking_app/features/change_password/presentation/view_model/change_pasword_ui_events.dart';

import 'change_password_cubit_test.mocks.dart';

@GenerateMocks([ChangePasswordUseCase])
Future<void> main() async {
  late ChangePasswordCubit cubit;
  late MockChangePasswordUseCase mockChangePasswordUseCase;
  late StreamController<ChangePaswordUiEvents> uiEventsController;
  late List<ChangePaswordUiEvents> emittedUiEvents;

  setUp(() {
    mockChangePasswordUseCase = MockChangePasswordUseCase();
    cubit = ChangePasswordCubit(mockChangePasswordUseCase);

    // Capture UI events
    uiEventsController = StreamController<ChangePaswordUiEvents>.broadcast();
    emittedUiEvents = [];
    cubit.uiEvents.listen((event) {
      emittedUiEvents.add(event);
    });
  });

  tearDown(() {
    emittedUiEvents.clear();
    uiEventsController.close();
    cubit.close();
  });

  const mockPasswordRequest = ChangePasswordRequestEntity(
    password: 'oldPassword',
    newPassword: 'NewPassword123!',
  );

  group('initial state', () {
    test('should have isValidForm as false', () {
      expect(cubit.state.isValidForm, isFalse);
    });
  });

  group('updatePassword', () {
    blocTest<ChangePasswordCubit, ChangePasswordStates>(
      'emits [loading, success] UI events when password change succeeds',
      build: () {
        when(
          mockChangePasswordUseCase.call(mockPasswordRequest),
        ).thenAnswer((_) async => const BaseResponse.success(null));
        return cubit;
      },
      act: (cubit) async {
        await cubit.doIntent(
          UpdatePasswordSubmitIntent(
            changePasswordRequestEntity: mockPasswordRequest,
          ),
        );
        // Wait for async operations
        await Future.delayed(const Duration(milliseconds: 100));
      },
      verify: (_) {
        verify(mockChangePasswordUseCase.call(mockPasswordRequest)).called(1);
        expect(emittedUiEvents.length, 2);
        expect(emittedUiEvents[0], isA<ChangePasswordLoadingEvent>());
        expect(emittedUiEvents[1], isA<ChangePasswordSuccessEvent>());
      },
    );

    blocTest<ChangePasswordCubit, ChangePasswordStates>(
      'emits [loading, failure] UI events when password change fails',
      build: () {
        when(mockChangePasswordUseCase.call(mockPasswordRequest)).thenAnswer(
          (_) async => BaseResponse.failure(
            UnknownException(message: 'Failed to change password'),
          ),
        );
        return cubit;
      },
      act: (cubit) async {
        await cubit.doIntent(
          UpdatePasswordSubmitIntent(
            changePasswordRequestEntity: mockPasswordRequest,
          ),
        );
        // Wait for async operations
        await Future.delayed(const Duration(milliseconds: 100));
      },
      verify: (_) {
        verify(mockChangePasswordUseCase.call(mockPasswordRequest)).called(1);
        expect(emittedUiEvents.length, 2);
        expect(emittedUiEvents[0], isA<ChangePasswordLoadingEvent>());
        expect(emittedUiEvents[1], isA<ChangePasswordFailureEvent>());

        final failureEvent = emittedUiEvents[1] as ChangePasswordFailureEvent;
        expect(failureEvent.message, isNotEmpty);
      },
    );
  });

  group('validateForm', () {
    blocTest<ChangePasswordCubit, ChangePasswordStates>(
      'emits valid form state when all fields are valid and passwords do not match',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(
        ValidateFields(
          password: 'OldPassword123!',
          newPassword: 'NewPassword123!',
          confirmPassword: 'NewPassword123!',
        ),
      ),
      expect: () => [
        predicate<ChangePasswordStates>((state) {
          return state.isValidForm == true;
        }),
      ],
    );

    blocTest<ChangePasswordCubit, ChangePasswordStates>(
      'emits invalid form state when password is invalid',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(
        ValidateFields(
          password: 'weak',
          newPassword: 'NewPassword123!',
          confirmPassword: 'NewPassword123!',
        ),
      ),
      expect: () => [
        predicate<ChangePasswordStates>((state) {
          return state.isValidForm == false;
        }),
      ],
    );

    blocTest<ChangePasswordCubit, ChangePasswordStates>(
      'emits invalid form state when new password is invalid',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(
        ValidateFields(
          password: 'OldPassword123!',
          newPassword: 'weak',
          confirmPassword: 'weak',
        ),
      ),
      expect: () => [
        predicate<ChangePasswordStates>((state) {
          return state.isValidForm == false;
        }),
      ],
    );

    blocTest<ChangePasswordCubit, ChangePasswordStates>(
      'emits invalid form state when old and new passwords are the same',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(
        ValidateFields(
          password: 'SamePassword123!',
          newPassword: 'SamePassword123!',
          confirmPassword: 'SamePassword123!',
        ),
      ),
      expect: () => [
        predicate<ChangePasswordStates>((state) {
          return state.isValidForm == false;
        }),
      ],
    );

    blocTest<ChangePasswordCubit, ChangePasswordStates>(
      'emits invalid form state when confirm password does not match new password',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(
        ValidateFields(
          password: 'OldPassword123!',
          newPassword: 'NewPassword123!',
          confirmPassword: 'DifferentPassword123!',
        ),
      ),
      expect: () => [
        predicate<ChangePasswordStates>((state) {
          return state.isValidForm == false;
        }),
      ],
    );

    blocTest<ChangePasswordCubit, ChangePasswordStates>(
      'emits invalid form state when all fields are empty',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(
        ValidateFields(password: '', newPassword: '', confirmPassword: ''),
      ),
      expect: () => [
        predicate<ChangePasswordStates>((state) {
          return state.isValidForm == false;
        }),
      ],
    );
  });

  group('UI events stream', () {
    test('UI events stream should not be null', () {
      expect(cubit.uiEvents, isNotNull);
    });

    test('UI events stream should be broadcast stream', () {
      // Multiple listeners should be able to listen
      final subscription1 = cubit.uiEvents.listen((_) {});
      final subscription2 = cubit.uiEvents.listen((_) {});

      expect(subscription1, isNotNull);
      expect(subscription2, isNotNull);

      subscription1.cancel();
      subscription2.cancel();
    });
  });
}
