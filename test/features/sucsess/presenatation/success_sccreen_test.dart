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
          path: AppRoutes.homeRoute,
          name: AppRoutes.homeRoute,
          builder: (context, state) =>
              const Scaffold(body: Center(child: Text('Home Screen'))),
        ),
      ],
    );
  });

  Widget createWidgetUnderTest() {
    return EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations', // This should match the path in pubspec.yaml
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
    // Set a larger viewport to avoid clipping issues
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.runAsync(() async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump(); // Initial pump to start EasyLocalization loading
    });

    // pumpAndSettle should wait for EasyLocalization to finish loading assets
    await tester.pumpAndSettle();
  }

  group('SuccessScreen Widget Tests', () {
    testWidgets('renders all UI elements correctly', (
      WidgetTester tester,
    ) async {
      await pumpScreen(tester);

      // Verify the Success image is rendered
      expect(find.byType(Image), findsOneWidget);
      final image = tester.widget<Image>(find.byType(Image));
      expect((image.image as AssetImage).assetName, AppAsset.successImage);

      // Verify texts are rendered
      expect(find.text(AppTextString.thankYou), findsOneWidget);
      expect(
        find.text(AppTextString.theOrderDeliveredSuccessfully),
        findsOneWidget,
      );

      // Verify the button is rendered
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text(AppTextString.done), findsOneWidget);
    });

    testWidgets('navigates to home screen when Done button is pressed', (
      WidgetTester tester,
    ) async {
      await pumpScreen(tester);

      // Find the Done button and tap it
      final doneButton = find.byType(ElevatedButton);
      expect(doneButton, findsOneWidget);

      await tester.tap(doneButton);
      await tester.pumpAndSettle();

      // Verify navigation to Home Screen occurred
      expect(find.text('Home Screen'), findsOneWidget);
      expect(find.byType(SuccessScreen), findsNothing);
    });
  });
}
