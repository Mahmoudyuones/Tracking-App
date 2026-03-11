import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracking_app/config/base_state/base_state.dart';
import 'package:tracking_app/features/my_profile/domain/entities/driver_response_entity.dart';
import 'package:tracking_app/features/my_profile/presentation/view_model/my_profile_cubit.dart';
import 'package:tracking_app/features/my_profile/presentation/view_model/my_profile_state.dart';
import 'package:tracking_app/features/my_profile/presentation/view_model/my_profile_ui_events.dart';
import 'package:tracking_app/features/my_profile/presentation/views/screens/my_profile_screen.dart';
import 'package:tracking_app/features/my_profile/presentation/views/widgets/profile_appbar.dart';
import 'package:tracking_app/features/my_profile/presentation/views/widgets/user_info_card.dart';
import 'package:tracking_app/features/my_profile/presentation/views/widgets/vehicle_info_card.dart';

import '../../mocks.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // ── Shared test data ────────────────────────────────────────────────────────

  MyProfileState emptyState() => MyProfileState(
    myProfileState: const BaseState<DriverResponseEntity>(),
    logoutState: const BaseState<void>(),
  );

  MyProfileState errorState(String msg) => MyProfileState(
    myProfileState: BaseState<DriverResponseEntity>(errorMessage: msg),
    logoutState: const BaseState<void>(),
  );

  // ── Shared infrastructure ───────────────────────────────────────────────────

  late MockMyProfileCubit mockCubit;
  late StreamController<MyProfileUiEvent> uiEventController;
  late StreamController<MyProfileState> stateController;
  final getIt = GetIt.instance;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  void initMock(MyProfileState initialState) {
    mockCubit = MockMyProfileCubit();
    uiEventController = StreamController<MyProfileUiEvent>.broadcast();
    stateController = StreamController<MyProfileState>.broadcast();

    when(mockCubit.state).thenReturn(initialState);
    when(mockCubit.stream).thenAnswer((_) => stateController.stream);
    when(mockCubit.uiEventStream).thenAnswer((_) => uiEventController.stream);
    when(mockCubit.isClosed).thenReturn(false);
    when(mockCubit.close()).thenAnswer((_) async {});
    when(mockCubit.onEvent(any)).thenReturn(null);

    if (!getIt.isRegistered<MyProfileCubit>()) {
      getIt.registerFactory<MyProfileCubit>(() => mockCubit);
    }
  }

  setUp(() => initMock(emptyState()));

  tearDown(() async {
    if (getIt.isRegistered<MyProfileCubit>()) {
      await getIt.unregister<MyProfileCubit>();
    }
    if (!uiEventController.isClosed) await uiEventController.close();
    if (!stateController.isClosed) await stateController.close();
  });

  // ── Widget builder ──────────────────────────────────────────────────────────

  Widget buildScreen() {
    return EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: Builder(
        builder: (ctx) => MaterialApp(
          localizationsDelegates: [...EasyLocalization.of(ctx)!.delegates],
          supportedLocales: const [Locale('en'), Locale('ar')],
          locale: const Locale('en'),
          home: const Scaffold(
            body: SingleChildScrollView(child: MyProfileScreen()),
          ),
        ),
      ),
    );
  }

  /// Pumps the screen with a tall viewport so MyProfileScreen's Column is
  /// never clipped. Uses [pumpAndSettle] so EasyLocalization's async
  /// translation loading finishes. If [emitState] is provided the state is
  /// pushed through [stateController] **before** settling so that
  /// [BlocBuilder] rebuilds with the new data.
  ///
  /// For states containing [CachedNetworkImage] (success state) we use a
  /// fixed-duration pump to avoid an infinite settle loop caused by the
  /// image-load retry timer.
  Future<void> pumpScreen(
    WidgetTester tester, {
    MyProfileState? emitState,
    bool useSettle = true,
  }) async {
    // Tall surface so the full Column (ProfileAppBar + cards + LanguageCard +
    // LogoutCard) is always visible inside the viewport.
    tester.view.physicalSize = const Size(1080, 2800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(buildScreen());

    if (useSettle) {
      // pumpAndSettle lets EasyLocalization finish async loading.
      await tester.pumpAndSettle();
    } else {
      // For states that include CachedNetworkImage (network images),
      // pumpAndSettle loops forever. Use multiple pump frames instead.
      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(milliseconds: 200));
      }
    }

    if (emitState != null) {
      stateController.add(emitState);
      if (useSettle) {
        await tester.pumpAndSettle();
      } else {
        for (var i = 0; i < 5; i++) {
          await tester.pump(const Duration(milliseconds: 200));
        }
      }
    }
  }

  // ── Initial / empty state ───────────────────────────────────────────────────

  group('MyProfileScreen — initial state (no data, no error)', () {
    testWidgets('renders ProfileAppBar', (tester) async {
      await pumpScreen(tester);
      expect(find.byType(ProfileAppBar), findsOneWidget);
    });

    testWidgets('does NOT show UserInfoCard', (tester) async {
      await pumpScreen(tester);
      expect(find.byType(UserInfoCard), findsNothing);
    });

    testWidgets('does NOT show VehicleInfoCard', (tester) async {
      await pumpScreen(tester);
      expect(find.byType(VehicleInfoCard), findsNothing);
    });
  });

  // ── Error state ─────────────────────────────────────────────────────────────

  group('MyProfileScreen — error state', () {
    const errorMsg = 'Network failure';

    Future<void> pumpError(WidgetTester tester) =>
        pumpScreen(tester, emitState: errorState(errorMsg));

    testWidgets('does NOT show UserInfoCard', (tester) async {
      await pumpError(tester);
      expect(find.byType(UserInfoCard), findsNothing);
    });

    testWidgets('does NOT show VehicleInfoCard', (tester) async {
      await pumpError(tester);
      expect(find.byType(VehicleInfoCard), findsNothing);
    });
  });
}
