import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tracking_app/features/taps/profile_tab/my_profile/presentation/views/widgets/language_option.dart';

Widget _buildTestWidget({
  required String label,
  required bool isSelected,
  VoidCallback? onTap,
}) {
  return MaterialApp(
    home: Scaffold(
      body: LanguageOption(
        label: label,
        isSelected: isSelected,
        onTap: onTap ?? () {},
      ),
    ),
  );
}

void main() {
  group('LanguageOption — unselected state', () {
    testWidgets('renders without errors', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(label: 'English', isSelected: false),
      );
      expect(find.byType(LanguageOption), findsOneWidget);
    });

    testWidgets('shows the label text', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(label: 'English', isSelected: false),
      );
      expect(find.text('English'), findsOneWidget);
    });

    testWidgets('does NOT show a check icon when unselected', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(label: 'English', isSelected: false),
      );
      await tester.pumpAndSettle(); // allow AnimatedSwitcher to complete
      expect(find.byIcon(Icons.check), findsNothing);
    });

    testWidgets('has an InkWell for tap interaction', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(label: 'English', isSelected: false),
      );
      expect(find.byType(InkWell), findsOneWidget);
    });
  });

  group('LanguageOption — selected state', () {
    testWidgets('renders without errors', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(label: 'Arabic', isSelected: true),
      );
      expect(find.byType(LanguageOption), findsOneWidget);
    });

    testWidgets('shows the label text', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(label: 'Arabic', isSelected: true),
      );
      expect(find.text('Arabic'), findsOneWidget);
    });

    testWidgets('shows a check icon when selected', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(label: 'Arabic', isSelected: true),
      );
      await tester.pumpAndSettle(); // allow AnimatedSwitcher to complete
      expect(find.byIcon(Icons.check), findsOneWidget);
    });
  });

  group('LanguageOption — onTap callback', () {
    testWidgets('invokes onTap when tapped', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        _buildTestWidget(
          label: 'English',
          isSelected: false,
          onTap: () => tapped = true,
        ),
      );
      await tester.tap(find.byType(InkWell));
      await tester.pump();
      expect(tapped, isTrue);
    });

    testWidgets('invokes onTap when tapped in selected state', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        _buildTestWidget(
          label: 'Arabic',
          isSelected: true,
          onTap: () => tapped = true,
        ),
      );
      await tester.tap(find.byType(InkWell));
      await tester.pump();
      expect(tapped, isTrue);
    });
  });

  group('LanguageOption — layout', () {
    testWidgets('contains a Row', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(label: 'English', isSelected: false),
      );
      expect(find.byType(Row), findsOneWidget);
    });

    testWidgets('contains an AnimatedContainer', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(label: 'English', isSelected: false),
      );
      expect(find.byType(AnimatedContainer), findsOneWidget);
    });

    testWidgets('contains an AnimatedSwitcher', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(label: 'English', isSelected: false),
      );
      expect(find.byType(AnimatedSwitcher), findsOneWidget);
    });
  });
}
