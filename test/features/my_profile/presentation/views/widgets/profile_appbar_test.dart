import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tracking_app/features/taps/profile_tab/my_profile/presentation/views/widgets/profile_appbar.dart';

/// Wraps [child] in a minimal [MaterialApp] so [Theme] and [Navigator] are available.
Widget _buildTestWidget(Widget child) {
  return MaterialApp(home: Scaffold(body: child));
}

void main() {
  group('ProfileAppBar', () {
    testWidgets('renders without errors', (tester) async {
      await tester.pumpWidget(_buildTestWidget(const ProfileAppBar()));
      expect(find.byType(ProfileAppBar), findsOneWidget);
    });

    testWidgets('displays the notifications_outlined icon', (tester) async {
      await tester.pumpWidget(_buildTestWidget(const ProfileAppBar()));
      expect(find.byIcon(Icons.notifications_outlined), findsOneWidget);
    });

    testWidgets('contains a GestureDetector for the nav title', (tester) async {
      await tester.pumpWidget(_buildTestWidget(const ProfileAppBar()));
      expect(find.byType(GestureDetector), findsWidgets);
    });

    testWidgets('is wrapped in a Padding widget', (tester) async {
      await tester.pumpWidget(_buildTestWidget(const ProfileAppBar()));
      expect(find.byType(Padding), findsWidgets);
    });

    testWidgets('lays out title and icon in a Row', (tester) async {
      await tester.pumpWidget(_buildTestWidget(const ProfileAppBar()));
      expect(find.byType(Row), findsOneWidget);
    });

    testWidgets('calls Navigator.maybePop when title tapped', (tester) async {
      // Push a second route so maybePop actually has a route to pop.
      final navigatorKey = GlobalKey<NavigatorState>();
      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: navigatorKey,
          routes: {
            '/': (_) => const Scaffold(body: Text('Home')),
            '/profile': (_) => const Scaffold(body: ProfileAppBar()),
          },
        ),
      );

      // Navigate to /profile.
      navigatorKey.currentState!.pushNamed('/profile');
      await tester.pumpAndSettle();

      // Verify the ProfileAppBar is visible.
      expect(find.byType(ProfileAppBar), findsOneWidget);

      // Tap the GestureDetector (the title text area).
      await tester.tap(find.byType(GestureDetector).first);
      await tester.pumpAndSettle();

      // Navigator popped back to home.
      expect(find.text('Home'), findsOneWidget);
    });
  });
}
