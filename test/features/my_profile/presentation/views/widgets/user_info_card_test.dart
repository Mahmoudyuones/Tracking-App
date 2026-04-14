import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tracking_app/features/taps/profile_tab/my_profile/presentation/views/widgets/user_info_card.dart';

Widget _buildTestWidget({
  String name = 'John Doe',
  String email = 'john@example.com',
  String phone = '+1234567890',
  String image = 'https://example.com/photo.jpg',
}) {
  return MaterialApp(
    home: Scaffold(
      body: UserInfoCard(name: name, email: email, phone: phone, image: image),
    ),
  );
}

void main() {
  group('UserInfoCard', () {
    testWidgets('renders without errors', (tester) async {
      await tester.pumpWidget(_buildTestWidget());
      expect(find.byType(UserInfoCard), findsOneWidget);
    });

    testWidgets('displays the driver name', (tester) async {
      await tester.pumpWidget(_buildTestWidget(name: 'John Doe'));
      expect(find.text('John Doe'), findsOneWidget);
    });

    testWidgets('displays the driver email', (tester) async {
      await tester.pumpWidget(_buildTestWidget(email: 'john@example.com'));
      expect(find.text('john@example.com'), findsOneWidget);
    });

    testWidgets('displays the driver phone', (tester) async {
      await tester.pumpWidget(_buildTestWidget(phone: '+1234567890'));
      expect(find.text('+1234567890'), findsOneWidget);
    });

    testWidgets('shows the chevron_right_rounded icon', (tester) async {
      await tester.pumpWidget(_buildTestWidget());
      expect(find.byIcon(Icons.chevron_right_rounded), findsOneWidget);
    });

    testWidgets('shows a CircleAvatar', (tester) async {
      await tester.pumpWidget(_buildTestWidget());
      expect(find.byType(CircleAvatar), findsOneWidget);
    });

    testWidgets('tapping the card does not throw', (tester) async {
      await tester.pumpWidget(_buildTestWidget());
      await tester.tap(find.byType(UserInfoCard));
      await tester.pump();
    });

    testWidgets('displays different user data correctly', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(
          name: 'Jane Smith',
          email: 'jane@test.com',
          phone: '+0987654321',
        ),
      );
      expect(find.text('Jane Smith'), findsOneWidget);
      expect(find.text('jane@test.com'), findsOneWidget);
      expect(find.text('+0987654321'), findsOneWidget);
    });

    testWidgets('is contained in a horizontal Row layout', (tester) async {
      await tester.pumpWidget(_buildTestWidget());
      expect(find.byType(Row), findsOneWidget);
    });

    testWidgets('contains an Expanded widget for the text column', (
      tester,
    ) async {
      await tester.pumpWidget(_buildTestWidget());
      // The Column of name/email/phone is wrapped in Expanded.
      expect(find.byType(Expanded), findsOneWidget);
    });
  });
}
