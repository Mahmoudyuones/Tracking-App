import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tracking_app/features/my_profile/presentation/views/widgets/vehicle_info_card.dart';

Widget _buildTestWidget({String type = 'Truck', String number = 'ABC-1234'}) {
  return MaterialApp(
    home: Scaffold(
      body: VehicleInfoCard(type: type, number: number),
    ),
  );
}

void main() {
  group('VehicleInfoCard', () {
    testWidgets('renders without errors', (tester) async {
      await tester.pumpWidget(_buildTestWidget());
      expect(find.byType(VehicleInfoCard), findsOneWidget);
    });

    testWidgets('displays the vehicle type', (tester) async {
      await tester.pumpWidget(_buildTestWidget(type: 'Truck'));
      expect(find.text('Truck'), findsOneWidget);
    });

    testWidgets('displays the vehicle number', (tester) async {
      await tester.pumpWidget(_buildTestWidget(number: 'ABC-1234'));
      expect(find.text('ABC-1234'), findsOneWidget);
    });

    testWidgets('shows the chevron_right_rounded icon', (tester) async {
      await tester.pumpWidget(_buildTestWidget());
      expect(find.byIcon(Icons.chevron_right_rounded), findsOneWidget);
    });

    testWidgets('has a GestureDetector', (tester) async {
      await tester.pumpWidget(_buildTestWidget());
      expect(find.byType(GestureDetector), findsOneWidget);
    });

    testWidgets('is wrapped in a Container', (tester) async {
      await tester.pumpWidget(_buildTestWidget());
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('tapping the card does not throw', (tester) async {
      await tester.pumpWidget(_buildTestWidget());
      await tester.tap(find.byType(GestureDetector).first);
      await tester.pump();
    });

    testWidgets('displays different vehicle type correctly', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(type: 'Van', number: 'XYZ-9999'),
      );
      expect(find.text('Van'), findsOneWidget);
      expect(find.text('XYZ-9999'), findsOneWidget);
    });
  });
}
