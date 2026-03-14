import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracking_app/config/base_state/base_state.dart';
import 'package:tracking_app/core/constants/app_text_string.dart';
import 'package:tracking_app/features/orders/domain/entities/order_entity.dart';
import 'package:tracking_app/features/orders/domain/entities/order_wrapper_entity.dart';
import 'package:tracking_app/features/orders/domain/entities/orders_response_entity.dart';
import 'package:tracking_app/features/orders/domain/entities/store_entity.dart';
import 'package:tracking_app/features/orders/domain/entities/user_entity.dart';
import 'package:tracking_app/features/orders/presentation/view_model/orders_cubit.dart';
import 'package:tracking_app/features/orders/presentation/view_model/orders_state.dart';
import 'package:tracking_app/features/orders/presentation/view_model/orders_ui_events.dart';
import 'package:tracking_app/features/orders/presentation/views/screens/driver_orders_screen.dart';
import 'package:tracking_app/features/orders/presentation/views/widgets/my_orders_app_bar.dart';
import 'package:tracking_app/features/orders/presentation/views/widgets/order_card.dart';
import 'package:tracking_app/features/orders/presentation/views/widgets/order_counters_row.dart';
import 'driver_orders_screen_test.mocks.dart';

@GenerateMocks([OrdersCubit])
const _user = UserEntity(
  id: 'user_1',
  firstName: 'John',
  lastName: 'Doe',
  email: 'john@example.com',
  phone: '123456789',
);

const _store = StoreEntity(
  name: 'Test Store',
  address: '123 Store St',
  phoneNumber: '987654321',
  latLong: '30.0,31.0',
);

OrderEntity _makeOrderEntity({
  String state = 'pending',
  String id = 'order_1',
}) => OrderEntity(
  id: id,
  user: _user,
  orderItems: const [],
  totalPrice: 50.0,
  paymentType: 'cash',
  isPaid: false,
  isDelivered: false,
  state: state,
  createdAt: DateTime(2024),
  orderNumber: 'ORD-$id',
);

OrderWrapperEntity _makeWrapper({
  String id = 'wrapper_1',
  String orderState = 'pending',
}) => OrderWrapperEntity(
  id: id,
  driver: 'driver_$id',
  order: _makeOrderEntity(state: orderState, id: 'order_$id'),
  createdAt: DateTime(2024),
  store: _store,
);

OrdersState _emptyState() =>
    OrdersState(ordersState: const BaseState<OrdersResponseEntity>());

OrdersState _errorState(String message) => OrdersState(
  ordersState: BaseState<OrdersResponseEntity>(errorMessage: message),
);

OrdersState _successState({
  List<OrderWrapperEntity> orders = const [],
  int completedCount = 0,
  int cancelledCount = 0,
}) => OrdersState(
  ordersState: BaseState<OrdersResponseEntity>(
    data: OrdersResponseEntity(
      orders: orders,
      completedCount: completedCount,
      cancelledCount: cancelledCount,
    ),
  ),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final getIt = GetIt.instance;
  late MockOrdersCubit mockCubit;
  late StreamController<OrdersUiEvent> uiEventController;
  late StreamController<OrdersState> stateController;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    const MethodChannel channel = MethodChannel(
      'plugins.flutter.io/path_provider',
    );
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          return '.';
        });

    SharedPreferences.setMockInitialValues({});

    await EasyLocalization.ensureInitialized();
  });

  void initMock(OrdersState initialState) {
    mockCubit = MockOrdersCubit();
    uiEventController = StreamController<OrdersUiEvent>.broadcast();
    stateController = StreamController<OrdersState>.broadcast();

    when(mockCubit.state).thenReturn(initialState);
    when(mockCubit.stream).thenAnswer((_) => stateController.stream);
    when(mockCubit.uiEventStream).thenAnswer((_) => uiEventController.stream);
    when(mockCubit.isClosed).thenReturn(false);
    when(mockCubit.close()).thenAnswer((_) async {});
    when(mockCubit.onEvent(any)).thenReturn(null);

    if (getIt.isRegistered<OrdersCubit>()) getIt.unregister<OrdersCubit>();
    getIt.registerFactory<OrdersCubit>(() => mockCubit);
  }

  setUp(() => initMock(_emptyState()));

  tearDown(() async {
    if (getIt.isRegistered<OrdersCubit>()) {
      await getIt.unregister<OrdersCubit>();
    }
    if (!uiEventController.isClosed) await uiEventController.close();
    if (!stateController.isClosed) await stateController.close();
  });

  Future<void> pumpScreen(WidgetTester tester, OrdersState state) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    initMock(state);

    await tester.runAsync(() async {
      await tester.pumpWidget(
        EasyLocalization(
          supportedLocales: const [Locale('en')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en'),
          child: const MaterialApp(home: Scaffold(body: DriverOrdersScreen())),
        ),
      );
    });

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
  }

  group('initial state -', () {
    testWidgets('renders nothing when data and error are both null', (
      tester,
    ) async {
      await pumpScreen(tester, _emptyState());

      expect(find.byType(MyOrdersAppBar), findsNothing);
      expect(find.byType(OrderCountersRow), findsNothing);
      expect(find.byType(OrderCard), findsNothing);
    });

    testWidgets('dispatches GetOrdersEvent on init', (tester) async {
      await pumpScreen(tester, _emptyState());

      verify(mockCubit.onEvent(any)).called(1);
    });
  });

  group('error state -', () {
    const errorMsg = 'Failed to fetch orders';

    testWidgets('shows app bar, error message, and retry button', (
      tester,
    ) async {
      await pumpScreen(tester, _errorState(errorMsg));

      expect(find.byType(MyOrdersAppBar), findsOneWidget);
      expect(find.text(errorMsg), findsOneWidget);
      expect(find.text(AppTextString.retry), findsOneWidget);
    });

    testWidgets('does not show counters row or order cards', (tester) async {
      await pumpScreen(tester, _errorState(errorMsg));

      expect(find.byType(OrderCountersRow), findsNothing);
      expect(find.byType(OrderCard), findsNothing);
    });

    testWidgets('retry button dispatches a new event', (tester) async {
      await pumpScreen(tester, _errorState(errorMsg));

      await tester.tap(find.text(AppTextString.retry));
      await tester.pump();

      verify(mockCubit.onEvent(any)).called(2);
    });
  });

  group('success state (empty orders) -', () {
    testWidgets('shows app bar and counters row', (tester) async {
      await pumpScreen(
        tester,
        _successState(completedCount: 5, cancelledCount: 1),
      );

      expect(find.byType(MyOrdersAppBar), findsOneWidget);
      expect(find.byType(OrderCountersRow), findsOneWidget);
    });

    testWidgets('shows empty-state icon and label', (tester) async {
      await pumpScreen(tester, _successState());

      expect(find.byIcon(Icons.inbox_outlined), findsOneWidget);
      expect(find.text(AppTextString.noOrdersFound), findsOneWidget);
    });

    testWidgets('does not render any OrderCard', (tester) async {
      await pumpScreen(tester, _successState());

      expect(find.byType(OrderCard), findsNothing);
    });
  });

  group('success state (with orders) -', () {
    testWidgets('shows app bar, counters row, and correct card count', (
      tester,
    ) async {
      final orders = [_makeWrapper(id: '1'), _makeWrapper(id: '2')];

      await pumpScreen(
        tester,
        _successState(orders: orders, completedCount: 10, cancelledCount: 2),
      );

      expect(find.byType(MyOrdersAppBar), findsOneWidget);
      expect(find.byType(OrderCountersRow), findsOneWidget);

      expect(find.byType(OrderCard, skipOffstage: false), findsNWidgets(2));
    });

    testWidgets('does not show empty-state label when orders exist', (
      tester,
    ) async {
      await pumpScreen(tester, _successState(orders: [_makeWrapper()]));

      expect(find.text(AppTextString.noOrdersFound), findsNothing);
    });

    testWidgets('counters row reflects correct counts', (tester) async {
      await pumpScreen(
        tester,
        _successState(
          orders: [_makeWrapper()],
          completedCount: 7,
          cancelledCount: 3,
        ),
      );

      expect(find.text('7'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
    });
  });
}
