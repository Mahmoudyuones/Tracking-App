import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracking_app/core/constants/app_asset.dart';
import 'package:tracking_app/core/constants/app_text_string.dart';
import 'package:tracking_app/core/routes/app_routes.dart';
import 'package:tracking_app/features/sucsess/presenatation/success_sccreen.dart';

void main() {
  late GoRouter router;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  setUp(() {
    router = GoRouter(
      initialLocation: AppRoutes.successRoute,
      routes: [
        GoRoute(
          path: AppRoutes.successRoute,
          name: AppRoutes.successRoute,
          builder: (context, state) => const SuccessScreen(),
        ),
        GoRoute(
          path: AppRoutes.mainRoute,
          name: AppRoutes.mainRoute,
          builder: (context, state) =>
              const Scaffold(body: Center(child: Text('Home Screen'))),
        ),
      ],
    );
  });

  Widget createWidgetUnderTest() {
    return EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            routerConfig: router,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
          );
        },
      ),
    );
  }

  Future<void> pumpScreen(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.runAsync(() async {
      await tester.pumpWidget(createWidgetUnderTest());
      await Future.delayed(const Duration(seconds: 1));
    });

    await tester.pumpAndSettle(const Duration(seconds: 3));

    // ADD THIS - print what's actually rendered
    debugDumpApp();
  }

  group('SuccessScreen Widget Tests', () {
    testWidgets('renders all UI elements correctly', (
      WidgetTester tester,
    ) async {
      await pumpScreen(tester);

      // Verify the Success image is rendered via key
      expect(find.byKey(const Key('success_image')), findsOneWidget);

      // Verify the asset name is correct
      final image = tester.widget<Image>(
        find.byKey(const Key('success_image')),
      );
      expect((image.image as AssetImage).assetName, AppAsset.successImage);

      // Verify texts are rendered
      expect(find.text(AppTextString.thankYou), findsOneWidget);
      expect(
        find.text(AppTextString.theOrderDeliveredSuccessfully),
        findsOneWidget,
      );

      // Verify the button is rendered via key
      expect(find.byKey(const Key('done_button')), findsOneWidget);
      expect(find.text(AppTextString.done), findsOneWidget);
    });

    testWidgets('navigates to home screen when Done button is pressed', (
      WidgetTester tester,
    ) async {
      await pumpScreen(tester);

      // Find and tap the Done button via key
      final doneButton = find.byKey(const Key('done_button'));
      expect(doneButton, findsOneWidget);

      await tester.tap(doneButton);
      await tester.pumpAndSettle();

      // Verify navigation to Home Screen occurred
      expect(find.text('Home Screen'), findsOneWidget);
      expect(find.byType(SuccessScreen), findsNothing);
    });
  });
}
