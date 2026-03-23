import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/features/my_profile/presentation/view_model/my_profile_cubit.dart';
import 'package:tracking_app/features/my_profile/presentation/views/widgets/logout_card.dart';

import '../../mocks.mocks.dart';

void main() {
  late MockMyProfileCubit mockCubit;

  setUp(() {
    mockCubit = MockMyProfileCubit();
    when(mockCubit.onEvent(any)).thenReturn(null);
    when(mockCubit.isClosed).thenReturn(false);
    when(mockCubit.close()).thenAnswer((_) async {});
  });

  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<MyProfileCubit>.value(
          value: mockCubit,
          child: child,
        ),
      ),
    );
  }

  group('LogoutCard', () {
    testWidgets('renders without errors', (tester) async {
      await tester.pumpWidget(buildTestWidget(const LogoutCard()));
      expect(find.byType(LogoutCard), findsOneWidget);
    });

    testWidgets('displays logout_rounded icon', (tester) async {
      await tester.pumpWidget(buildTestWidget(const LogoutCard()));
      expect(find.byIcon(Icons.logout_rounded), findsWidgets);
    });

    testWidgets('contains an InkWell for tap interaction', (tester) async {
      await tester.pumpWidget(buildTestWidget(const LogoutCard()));
      expect(find.byType(InkWell), findsOneWidget);
    });

    testWidgets('contains a Row layout', (tester) async {
      await tester.pumpWidget(buildTestWidget(const LogoutCard()));
      expect(find.byType(Row), findsOneWidget);
    });

    testWidgets('shows at least one Icon widget', (tester) async {
      await tester.pumpWidget(buildTestWidget(const LogoutCard()));
      expect(find.byType(Icon), findsWidgets);
    });

    testWidgets('contains a Padding widget', (tester) async {
      await tester.pumpWidget(buildTestWidget(const LogoutCard()));
      expect(find.byType(Padding), findsWidgets);
    });
  });
}
