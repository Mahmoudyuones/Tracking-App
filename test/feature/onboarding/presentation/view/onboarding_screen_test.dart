import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracking_app/feature/onboarding/presentation/pages/onboarding_screen.dart';

import 'package:tracking_app/core/constants/app_text_string.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    PackageInfo.setMockInitialValues(
      appName: 'Tracking App',
      packageName: 'com.example.tracking',
      version: '1.0.0',
      buildNumber: '1',
      buildSignature: '',
      installerStore: '',
    );


    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('OnBoardingScreen loads correctly and displays all elements',
          (WidgetTester tester) async {

        await tester.pumpWidget(
          const MaterialApp(
            home: OnBoardingScreen(),
          ),
        );

        expect(find.byType(Lottie), findsOneWidget, reason: 'Lottie animation should be present');

        expect(find.text(AppTextString.onboarding), findsOneWidget);
        expect(find.text(AppTextString.onboarding2), findsOneWidget);
        expect(find.text(AppTextString.login), findsOneWidget);
        expect(find.text(AppTextString.applyNow), findsOneWidget);


        expect(find.byType(ElevatedButton), findsOneWidget, reason: 'Login button missing');
        expect(find.byType(OutlinedButton), findsOneWidget, reason: 'Apply Now button missing');

        expect(find.text('1.0.0'), findsOneWidget, reason: 'Package version did not load correctly');


        expect(find.byType(SingleChildScrollView), findsOneWidget, reason: 'Screen should be scrollable');
      });

  testWidgets('Buttons are clickable', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: OnBoardingScreen(),
      ),
    );

    final applyButton = find.byType(OutlinedButton);
    await tester.tap(applyButton);
  });
}