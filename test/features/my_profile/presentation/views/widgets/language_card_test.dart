import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracking_app/config/base_state/base_state.dart';
import 'package:tracking_app/features/my_profile/domain/entities/driver_response_entity.dart';
import 'package:tracking_app/features/my_profile/presentation/view_model/my_profile_state.dart';
import 'package:tracking_app/features/my_profile/presentation/view_model/my_profile_ui_events.dart';
import 'package:tracking_app/features/my_profile/presentation/views/widgets/language_card.dart';

import '../../mocks.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockMyProfileCubit mockCubit;
  late StreamController<MyProfileUiEvent> uiEventController;
  late StreamController<MyProfileState> stateController;

  final emptyState = MyProfileState(
    myProfileState: const BaseState<DriverResponseEntity>(),
  );

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  setUp(() {
    mockCubit = MockMyProfileCubit();
    uiEventController = StreamController<MyProfileUiEvent>.broadcast();
    stateController = StreamController<MyProfileState>.broadcast();

    when(mockCubit.uiEventStream).thenAnswer((_) => uiEventController.stream);
    when(mockCubit.stream).thenAnswer((_) => stateController.stream);
    when(mockCubit.state).thenReturn(emptyState);
    when(mockCubit.isClosed).thenReturn(false);
    when(mockCubit.close()).thenAnswer((_) async {});
    // Must stub onEvent because throwOnMissingStub is enabled in the generated mock
    when(mockCubit.onEvent(any)).thenReturn(null);
  });

  tearDown(() async {
    await uiEventController.close();
    await stateController.close();
  });

  /// Builds the full widget tree with localization + BLoC context.
  ///
  /// EasyLocalization loads translations asynchronously, so every test
  /// must call [tester.pumpAndSettle] after [tester.pumpWidget] to let
  /// locale initialization finish before asserting on widget content.
  Widget buildWidget(MockMyProfileCubit cubit) {
    return EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: Builder(
        builder: (ctx) => MaterialApp(
          locale: EasyLocalization.of(ctx)?.locale ?? const Locale('en'),
          supportedLocales: const [Locale('en'), Locale('ar')],
          localizationsDelegates:
              EasyLocalization.of(ctx)?.delegates ?? const [],
          home: Scaffold(
            body: BlocProvider.value(value: cubit, child: const LanguageCard()),
          ),
        ),
      ),
    );
  }

  group('LanguageCard', () {
    testWidgets('renders without errors', (tester) async {
      await tester.pumpWidget(buildWidget(mockCubit));
      await tester.pumpAndSettle();
      expect(find.byType(LanguageCard), findsOneWidget);
    });
  });
}
