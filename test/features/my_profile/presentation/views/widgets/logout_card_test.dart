import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tracking_app/features/my_profile/presentation/views/widgets/logout_card.dart';

Widget _buildTestWidget(Widget child) {
  return MaterialApp(home: Scaffold(body: child));
}

void main() {
  group('LogoutCard', () {
    testWidgets('renders without errors', (tester) async {
      await tester.pumpWidget(_buildTestWidget(const LogoutCard()));
      expect(find.byType(LogoutCard), findsOneWidget);
    });

    testWidgets('displays logout_rounded icon', (tester) async {
      await tester.pumpWidget(_buildTestWidget(const LogoutCard()));
      expect(find.byIcon(Icons.logout_rounded), findsWidgets);
    });

    testWidgets('contains an InkWell for tap interaction', (tester) async {
      await tester.pumpWidget(_buildTestWidget(const LogoutCard()));
      expect(find.byType(InkWell), findsOneWidget);
    });

    testWidgets('contains a Row layout', (tester) async {
      await tester.pumpWidget(_buildTestWidget(const LogoutCard()));
      expect(find.byType(Row), findsOneWidget);
    });

    testWidgets('shows at least one Icon widget', (tester) async {
      await tester.pumpWidget(_buildTestWidget(const LogoutCard()));
      expect(find.byType(Icon), findsWidgets);
    });

    testWidgets('contains a Padding widget', (tester) async {
      await tester.pumpWidget(_buildTestWidget(const LogoutCard()));
      expect(find.byType(Padding), findsWidgets);
    });

    testWidgets('tapping does not throw an error', (tester) async {
      await tester.pumpWidget(_buildTestWidget(const LogoutCard()));
      await tester.tap(find.byType(InkWell));
      await tester.pump();
      // No exception means the empty onTap handler works safely.
    });
  });
}
