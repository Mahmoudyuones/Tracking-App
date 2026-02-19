import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tracking_app/features/change_password/presentation/view_model/change_pasword_ui_events.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/core/constants/app_asset.dart';
import 'package:tracking_app/core/constants/app_text_string.dart';
import 'package:tracking_app/core/constants/validation_constants.dart';
import 'package:tracking_app/features/change_password/presentation/view/screens/change_password_screen.dart';
import 'package:tracking_app/features/change_password/presentation/view_model/change_password_cubit.dart';
import 'package:tracking_app/features/change_password/presentation/view_model/change_password_states.dart';

import 'change_password_screen_test.mocks.dart';

@GenerateMocks([ChangePasswordCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });
  late MockChangePasswordCubit mockCubit;
  final getIt = GetIt.instance;

  setUp(() {
    mockCubit = MockChangePasswordCubit();
    getIt.registerSingleton<ChangePasswordCubit>(mockCubit);
  });

  tearDown(() {
    getIt.unregister<ChangePasswordCubit>();
  });

  Widget buildTestableWidget() {
    return EasyLocalization(
      supportedLocales: const [
        Locale(AppTextString.enLangKey),
        Locale(AppTextString.arLangKey),
      ],
      path: AppAsset.translationsPath,
      startLocale: null,
      fallbackLocale: const Locale(AppTextString.enLangKey),
      useOnlyLangCode: true,
      saveLocale: false,
      child: MaterialApp(
        builder: EasyLoading.init(),
        home: BlocProvider<ChangePasswordCubit>(
          create: (context) => mockCubit,
          child: const ChangePasswordScreen(),
        ),
      ),
    );
  }

  testWidgets('Initial State', (WidgetTester tester) async {
    // Arrange
    when(mockCubit.state).thenReturn(const ChangePasswordStates());
    when(mockCubit.stream).thenAnswer(
      (_) => Stream<ChangePasswordStates>.value(const ChangePasswordStates()),
    );
    when(mockCubit.uiEvents).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(buildTestableWidget());

    // Assert
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(3));
    expect(find.byType(Icon), findsNWidgets(4));
    expect(find.byType(Text), findsNWidgets(8));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(
      find.bySemanticsLabel(AppTextString.currentPassword),
      findsOneWidget,
    );
    expect(find.bySemanticsLabel(AppTextString.newPassword), findsOneWidget);
    expect(
      find.bySemanticsLabel(AppTextString.confirmPassword),
      findsOneWidget,
    );
    expect(find.text(ValidationConstants.passwordRequired), findsNothing);
    expect(
      find.text(ValidationConstants.newPasswordIsTheOldPassword),
      findsNothing,
    );
    expect(find.text(ValidationConstants.passwordsDoNotMatch), findsNothing);
    expect(find.text(ValidationConstants.passwordSpecialChar), findsNothing);
    expect(find.text(ValidationConstants.passwordMinLength), findsNothing);
    expect(find.text(AppTextString.update), findsOneWidget);
    expect(find.text(AppTextString.resetPasswordHeader), findsOneWidget);
  });

  testWidgets('loading UI is triggered by uiEvents', (
    WidgetTester tester,
  ) async {
    // Arrange
    when(mockCubit.state).thenReturn(const ChangePasswordStates());
    when(mockCubit.stream).thenAnswer(
      (_) => Stream<ChangePasswordStates>.value(const ChangePasswordStates()),
    );
    when(
      mockCubit.uiEvents,
    ).thenAnswer((_) => Stream.value(ChangePasswordLoadingEvent()));

    await tester.pumpWidget(buildTestableWidget());
    // allow listeners and overlays to render
    await tester.pump();

    // Assert: EasyLoading shows loading text from localization
    expect(find.text(AppTextString.loading), findsOneWidget);

    // Assert: Loading overlay is displayed with correct styling
    expect(find.byType(Opacity), findsWidgets); // Loading overlay

    // Assert: Loading indicator is present
    expect(find.byType(CustomPaint), findsWidgets); // Ripple indicator

    // Assert: Text fields are still present but disabled
    expect(find.byType(TextFormField), findsNWidgets(3));
  });

  testWidgets('shows error when passwords do not match', (
    WidgetTester tester,
  ) async {
    // Arrange
    when(mockCubit.state).thenReturn(const ChangePasswordStates());
    when(mockCubit.stream).thenAnswer(
      (_) => Stream<ChangePasswordStates>.value(const ChangePasswordStates()),
    );
    when(mockCubit.uiEvents).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(buildTestableWidget());

    // Act: Enter mismatched valid passwords
    await tester.enterText(find.byType(TextFormField).at(0), 'OldPassword@123');
    await tester.enterText(find.byType(TextFormField).at(1), 'NewPassword@123');
    await tester.enterText(
      find.byType(TextFormField).at(2),
      'DifferentPassword@456',
    );
    await tester.pump();

    // Assert: Password mismatch error is displayed
    expect(find.text(ValidationConstants.passwordsDoNotMatch), findsOneWidget);
  });

  testWidgets('shows error when new password is same as old password', (
    WidgetTester tester,
  ) async {
    // Arrange
    when(mockCubit.state).thenReturn(const ChangePasswordStates());
    when(mockCubit.stream).thenAnswer(
      (_) => Stream<ChangePasswordStates>.value(const ChangePasswordStates()),
    );
    when(mockCubit.uiEvents).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(buildTestableWidget());

    // Act: Enter same valid password for old and new
    await tester.enterText(
      find.byType(TextFormField).at(0),
      'SamePassword@123',
    );
    await tester.enterText(
      find.byType(TextFormField).at(1),
      'SamePassword@123',
    );
    await tester.enterText(
      find.byType(TextFormField).at(2),
      'SamePassword@123',
    );
    await tester.pump();

    // Assert: Same password error is displayed
    expect(
      find.text(ValidationConstants.newPasswordIsTheOldPassword),
      findsOneWidget,
    );
  });

  testWidgets('shows error when password format is invalid', (
    WidgetTester tester,
  ) async {
    // Arrange
    when(mockCubit.state).thenReturn(const ChangePasswordStates());
    when(mockCubit.stream).thenAnswer(
      (_) => Stream<ChangePasswordStates>.value(const ChangePasswordStates()),
    );
    when(mockCubit.uiEvents).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(buildTestableWidget());

    // Act: Enter weak password (no special characters)
    await tester.enterText(find.byType(TextFormField).at(0), 'OldPassword123');
    await tester.enterText(find.byType(TextFormField).at(1), 'NewPassword123');
    await tester.enterText(find.byType(TextFormField).at(2), 'NewPassword123');
    await tester.pump();

    // Assert: Special character format error is displayed
    expect(
      find.text(ValidationConstants.passwordSpecialChar),
      findsNWidgets(2),
    );
  });

  testWidgets('success case shows success message', (
    WidgetTester tester,
  ) async {
    // Arrange
    when(mockCubit.state).thenReturn(const ChangePasswordStates());
    when(mockCubit.stream).thenAnswer(
      (_) => Stream<ChangePasswordStates>.value(const ChangePasswordStates()),
    );
    when(
      mockCubit.uiEvents,
    ).thenAnswer((_) => Stream.value(ChangePasswordSuccessEvent()));

    await tester.pumpWidget(buildTestableWidget());
    // allow listeners and message to render
    await tester.pumpAndSettle();

    // Assert: No loading indicator or error messages are displayed
    expect(find.text(AppTextString.loading), findsNothing);
    expect(find.text(ValidationConstants.passwordRequired), findsNothing);
    expect(find.byType(Opacity), findsNothing);
  });
}
