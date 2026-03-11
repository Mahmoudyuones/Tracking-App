import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:go_router/go_router.dart';
import 'package:tracking_app/features/change_password/presentation/view/screens/change_password_screen.dart';
import 'package:tracking_app/features/change_password/presentation/view_model/change_password_cubit.dart';
import 'package:tracking_app/features/change_password/presentation/view_model/change_password_states.dart';
import 'package:tracking_app/features/change_password/presentation/view_model/change_pasword_ui_events.dart';

import 'change_password_screen_test.mocks.dart';

@GenerateMocks([ChangePasswordCubit, GoRouter])
void main() {
  late MockChangePasswordCubit mockCubit;
  late MockGoRouter mockGoRouter;
  final getIt = GetIt.instance;

  setUp(() {
    mockCubit = MockChangePasswordCubit();
    mockGoRouter = MockGoRouter();

    if (getIt.isRegistered<ChangePasswordCubit>()) {
      getIt.unregister<ChangePasswordCubit>();
    }
    getIt.registerSingleton<ChangePasswordCubit>(mockCubit);

    when(mockCubit.uiEvents).thenAnswer((_) => const Stream.empty());
  });

  Widget buildTestableWidget({Key? key}) {
    return MaterialApp(
      home: InheritedGoRouter(
        goRouter: mockGoRouter,
        child: ChangePasswordScreen(key: key),
      ),
    );
  }

  group('ChangePasswordScreen - Simplified Tests', () {
    testWidgets('renders all fields and button', (tester) async {
      when(mockCubit.state).thenReturn(const ChangePasswordStates());
      when(mockCubit.stream).thenAnswer((_) => const Stream.empty());

      await tester.pumpWidget(buildTestableWidget());
      expect(find.byType(TextFormField), findsNWidgets(3));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('shows mismatch error when passwords do not match', (
      tester,
    ) async {
      when(mockCubit.state).thenReturn(const ChangePasswordStates());
      when(mockCubit.stream).thenAnswer((_) => const Stream.empty());

      await tester.pumpWidget(buildTestableWidget());

      await tester.enterText(
        find.byType(TextFormField).at(1),
        'NewPassword@123',
      );
      await tester.enterText(find.byType(TextFormField).at(2), 'Mismatch@123');
      await tester.pump();

      expect(find.textContaining('passwordsDoNotMatch'), findsOneWidget);
    });

    testWidgets('submit button enabled state reflects validity', (
      tester,
    ) async {
      when(mockCubit.stream).thenAnswer((_) => const Stream.empty());

      // Invalid
      when(
        mockCubit.state,
      ).thenReturn(const ChangePasswordStates(isValidForm: false));
      await tester.pumpWidget(buildTestableWidget(key: const Key('invalid')));
      expect(
        tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed,
        isNull,
      );

      // Valid
      when(
        mockCubit.state,
      ).thenReturn(const ChangePasswordStates(isValidForm: true));
      await tester.pumpWidget(buildTestableWidget(key: const Key('valid')));
      expect(
        tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed,
        isNotNull,
      );
    });

    testWidgets('successfully updates and pops screen', (tester) async {
      when(mockCubit.state).thenReturn(const ChangePasswordStates());
      when(mockCubit.stream).thenAnswer((_) => const Stream.empty());

      final controller = StreamController<ChangePaswordUiEvents>();
      when(mockCubit.uiEvents).thenAnswer((_) => controller.stream);

      await tester.pumpWidget(buildTestableWidget());

      controller.add(ChangePasswordSuccessEvent());
      await tester.pump();

      verify(mockGoRouter.pop()).called(1);
      controller.close();
    });
  });
}
