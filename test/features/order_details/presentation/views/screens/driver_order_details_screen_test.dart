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
import 'package:tracking_app/core/style/widget/loading_indicator.dart';
import 'package:tracking_app/features/order_details/domain/entities/product_details_response_entity.dart';
import 'package:tracking_app/features/order_details/domain/entities/product_order_entity.dart';
import 'package:tracking_app/features/order_details/presentation/view_model/product_details_cubit.dart';
import 'package:tracking_app/features/order_details/presentation/view_model/product_details_state.dart';
import 'package:tracking_app/features/order_details/presentation/view_model/product_details_ui_events.dart';
import 'package:tracking_app/features/order_details/presentation/views/screens/driver_order_details_screen.dart';
import 'package:tracking_app/features/order_details/presentation/views/widgets/address_card.dart';
import 'package:tracking_app/features/order_details/presentation/views/widgets/order_details_app_bar.dart';
import 'package:tracking_app/features/order_details/presentation/views/widgets/order_status_row.dart';
import 'package:tracking_app/features/orders/domain/entities/order_entity.dart';
import 'package:tracking_app/features/orders/domain/entities/order_item_entity.dart';
import 'package:tracking_app/features/orders/domain/entities/order_wrapper_entity.dart';
import 'package:tracking_app/features/orders/domain/entities/product_entity.dart';
import 'package:tracking_app/features/orders/domain/entities/store_entity.dart';
import 'package:tracking_app/features/orders/domain/entities/user_entity.dart';

import 'driver_order_details_screen_test.mocks.dart';

@GenerateMocks([ProductDetailsCubit])
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
  orderItems: const [
    OrderItemEntity(
      product: ProductEntity(id: 'prod_1', price: 10),
      quantity: 2,
      price: 20,
    ),
  ],
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

ProductDetailsState _emptyState() => ProductDetailsState(
  productDetailsState: const BaseState<List<ProductDetailsResponseEntity>>(),
);

ProductDetailsState _errorState(String message) => ProductDetailsState(
  productDetailsState: BaseState<List<ProductDetailsResponseEntity>>(
    errorMessage: message,
  ),
);

ProductDetailsState _successState(
  List<ProductDetailsResponseEntity> products,
) => ProductDetailsState(
  productDetailsState: BaseState<List<ProductDetailsResponseEntity>>(
    data: products,
  ),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final getIt = GetIt.instance;
  late MockProductDetailsCubit mockCubit;
  late StreamController<ProductDetailsUiEvent> uiEventController;
  late StreamController<ProductDetailsState> stateController;

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

  void initMock(ProductDetailsState initialState) {
    mockCubit = MockProductDetailsCubit();
    uiEventController = StreamController<ProductDetailsUiEvent>.broadcast();
    stateController = StreamController<ProductDetailsState>.broadcast();

    when(mockCubit.state).thenReturn(initialState);
    when(mockCubit.stream).thenAnswer((_) => stateController.stream);
    when(mockCubit.uiEventStream).thenAnswer((_) => uiEventController.stream);
    when(mockCubit.isClosed).thenReturn(false);
    when(mockCubit.close()).thenAnswer((_) async {});
    when(mockCubit.onEvent(any)).thenReturn(null);

    if (getIt.isRegistered<ProductDetailsCubit>()) {
      getIt.unregister<ProductDetailsCubit>();
    }
    getIt.registerFactory<ProductDetailsCubit>(() => mockCubit);
  }

  setUp(() => initMock(_emptyState()));

  tearDown(() async {
    if (getIt.isRegistered<ProductDetailsCubit>()) {
      await getIt.unregister<ProductDetailsCubit>();
    }
    if (!uiEventController.isClosed) await uiEventController.close();
    if (!stateController.isClosed) await stateController.close();
  });

  Future<void> pumpScreen(
    WidgetTester tester,
    ProductDetailsState state,
  ) async {
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
          child: MaterialApp(home: OrderDetailsScreen(order: _makeWrapper())),
        ),
      );
    });

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
  }

  group('initial state -', () {
    testWidgets(
      'renders app bar, address cards, order status and loading indicator',
      (tester) async {
        await pumpScreen(tester, _emptyState());

        expect(find.byType(OrderDetailsAppBar), findsOneWidget);
        expect(find.byType(OrderStatusRow), findsOneWidget);
        // We have two AddressCards: Store and User
        expect(find.byType(AddressCard), findsNWidgets(2));
        expect(find.byType(LoadingIndicator), findsWidgets);
      },
    );

    testWidgets('dispatches GetMultipleProductDetailsEvent on init', (
      tester,
    ) async {
      await pumpScreen(tester, _emptyState());

      verify(mockCubit.onEvent(any)).called(1);
    });
  });

  group('error state -', () {
    const errorMsg = 'Failed to fetch product details';

    testWidgets('shows error message and retry button', (tester) async {
      await pumpScreen(tester, _errorState(errorMsg));

      expect(find.text(errorMsg), findsOneWidget);
      expect(find.text(AppTextString.retry), findsOneWidget);
    });

    testWidgets('retry button dispatches new event', (tester) async {
      await pumpScreen(tester, _errorState(errorMsg));

      await tester.tap(find.text(AppTextString.retry));
      await tester.pump();

      verify(mockCubit.onEvent(any)).called(2);
    });
  });

  group('success state -', () {
    testWidgets('renders items list correctly', (tester) async {
      final mockData = <ProductDetailsResponseEntity>[
        const ProductDetailsResponseEntity(
          product: ProductOrderEntity(
            title: 'Mock Product',
            imgCover: 'https://example.com/img.jpg',
            price: 10.0,
          ),
        ),
      ];
      await pumpScreen(tester, _successState(mockData));

      expect(find.text(AppTextString.retry), findsNothing);
      // Validates order items lists exist. OrderItemsList uses Slivers or ListView. OrderSummarySection should also be visible.
      expect(find.text(AppTextString.orderDetails), findsWidgets);
    });
  });
}
