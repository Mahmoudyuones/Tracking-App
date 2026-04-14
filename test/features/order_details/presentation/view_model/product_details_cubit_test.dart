import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/config/exception/app_exception.dart';
import 'package:tracking_app/config/exception/unknown_exception.dart';
import 'package:tracking_app/features/taps/orders_tap/order_details/domain/entities/product_details_response_entity.dart';
import 'package:tracking_app/features/taps/orders_tap/order_details/domain/entities/product_order_entity.dart';
import 'package:tracking_app/features/taps/orders_tap/order_details/domain/usecases/get_product_details_usecase.dart';
import 'package:tracking_app/features/taps/orders_tap/order_details/presentation/view_model/product_details_cubit.dart';
import 'package:tracking_app/features/taps/orders_tap/order_details/presentation/view_model/product_details_events.dart';
import 'package:tracking_app/features/taps/orders_tap/order_details/presentation/view_model/product_details_state.dart';
import 'package:tracking_app/features/taps/orders_tap/order_details/presentation/view_model/product_details_ui_events.dart';

import 'product_details_cubit_test.mocks.dart';

@GenerateMocks([GetMultipleProductDetailsUseCase])
Future<void> main() async {
  late ProductDetailsCubit cubit;
  late MockGetMultipleProductDetailsUseCase
  mockGetMultipleProductDetailsUseCase;
  late List<ProductDetailsUiEvent> emittedUiEvents;

  const mockProductOrder1 = ProductOrderEntity(
    title: 'Product 1',
    imgCover: 'https://example.com/product1.jpg',
    price: 10.0,
  );

  const mockProductOrder2 = ProductOrderEntity(
    title: 'Product 2',
    imgCover: 'https://example.com/product2.jpg',
    price: 20.0,
  );

  const mockProductResponseEntity1 = ProductDetailsResponseEntity(
    product: mockProductOrder1,
  );

  const mockProductResponseEntity2 = ProductDetailsResponseEntity(
    product: mockProductOrder2,
  );

  setUp(() {
    mockGetMultipleProductDetailsUseCase =
        MockGetMultipleProductDetailsUseCase();
    cubit = ProductDetailsCubit(mockGetMultipleProductDetailsUseCase);

    emittedUiEvents = [];
    cubit.uiEventStream.listen((event) {
      emittedUiEvents.add(event);
    });
  });

  tearDown(() {
    emittedUiEvents.clear();
    cubit.close();
  });

  group('initial state', () {
    test(
      'productDetailsState should have no data, no error, and no isEmpty flag',
      () {
        expect(cubit.state.productDetailsState.data, isNull);
        expect(cubit.state.productDetailsState.errorMessage, isNull);
        expect(cubit.state.productDetailsState.isEmpty, isNull);
      },
    );
  });

  group('onEvent — GetMultipleProductDetailsEvent — success', () {
    blocTest<ProductDetailsCubit, ProductDetailsState>(
      'emits state with product data when usecase returns all products with no failures',
      build: () {
        when(mockGetMultipleProductDetailsUseCase.call(any)).thenAnswer(
          (_) async => (
            products: <ProductDetailsResponseEntity>[
              mockProductResponseEntity1,
              mockProductResponseEntity2,
            ],
            failures: <AppException>[],
          ),
        );
        return cubit;
      },
      act: (cubit) async {
        cubit.onEvent(GetMultipleProductDetailsEvent(productIds: ['1', '2']));
      },
      verify: (_) {
        verify(mockGetMultipleProductDetailsUseCase.call(['1', '2'])).called(1);

        expect(
          cubit.state.productDetailsState.data,
          equals([mockProductResponseEntity1, mockProductResponseEntity2]),
        );
      },
    );

    blocTest<ProductDetailsCubit, ProductDetailsState>(
      'emits [LoadingUiEvent, ProductDetailsSuccessUiEvent] on full success',
      build: () {
        when(mockGetMultipleProductDetailsUseCase.call(any)).thenAnswer(
          (_) async => (
            products: <ProductDetailsResponseEntity>[
              mockProductResponseEntity1,
            ],
            failures: <AppException>[],
          ),
        );
        return cubit;
      },
      act: (cubit) async {
        cubit.onEvent(GetMultipleProductDetailsEvent(productIds: ['1']));
      },
      verify: (_) {
        expect(emittedUiEvents.length, 2);
        expect(emittedUiEvents[0], isA<LoadingUiEvent>());
        expect(emittedUiEvents[1], isA<ProductDetailsSuccessUiEvent>());

        final successEvent = emittedUiEvents[1] as ProductDetailsSuccessUiEvent;
        expect(successEvent.products, equals([mockProductResponseEntity1]));
      },
    );
  });

  group('onEvent — GetMultipleProductDetailsEvent — partial success', () {
    final fakeException = UnknownException(
      message: 'Failed to fetch some products',
    );

    blocTest<ProductDetailsCubit, ProductDetailsState>(
      'emits state with product data and PartialSuccessUiEvent when usecase returns some products and some failures',
      build: () {
        when(mockGetMultipleProductDetailsUseCase.call(any)).thenAnswer(
          (_) async => (
            products: <ProductDetailsResponseEntity>[
              mockProductResponseEntity1,
            ],
            failures: <AppException>[fakeException],
          ),
        );
        return cubit;
      },
      act: (cubit) async {
        cubit.onEvent(GetMultipleProductDetailsEvent(productIds: ['1', '2']));
      },
      verify: (_) {
        verify(mockGetMultipleProductDetailsUseCase.call(['1', '2'])).called(1);

        expect(
          cubit.state.productDetailsState.data,
          equals([mockProductResponseEntity1]),
        );
        expect(cubit.state.productDetailsState.errorMessage, isNull);

        expect(emittedUiEvents.length, 2);
        expect(emittedUiEvents[0], isA<LoadingUiEvent>());
        expect(emittedUiEvents[1], isA<PartialSuccessUiEvent>());

        final partialSuccessEvent = emittedUiEvents[1] as PartialSuccessUiEvent;
        expect(
          partialSuccessEvent.products,
          equals([mockProductResponseEntity1]),
        );
      },
    );
  });

  group('onEvent — GetMultipleProductDetailsEvent — failure', () {
    final fakeException = UnknownException(message: 'Failed to fetch products');

    blocTest<ProductDetailsCubit, ProductDetailsState>(
      'emits state with errorMessage when usecase returns NO products and SOME failures',
      build: () {
        when(mockGetMultipleProductDetailsUseCase.call(any)).thenAnswer(
          (_) async => (
            products: <ProductDetailsResponseEntity>[],
            failures: <AppException>[fakeException],
          ),
        );
        return cubit;
      },
      act: (cubit) async {
        cubit.onEvent(GetMultipleProductDetailsEvent(productIds: ['1']));
      },
      verify: (_) {
        verify(mockGetMultipleProductDetailsUseCase.call(['1'])).called(1);

        expect(cubit.state.productDetailsState.data, isNull);
        expect(
          cubit.state.productDetailsState.errorMessage,
          equals('Failed to fetch products'),
        );
      },
    );

    blocTest<ProductDetailsCubit, ProductDetailsState>(
      'emits [LoadingUiEvent, ErrorUiEvent] on total failure',
      build: () {
        when(mockGetMultipleProductDetailsUseCase.call(any)).thenAnswer(
          (_) async => (
            products: <ProductDetailsResponseEntity>[],
            failures: <AppException>[fakeException],
          ),
        );
        return cubit;
      },
      act: (cubit) async {
        cubit.onEvent(GetMultipleProductDetailsEvent(productIds: ['1']));
      },
      verify: (_) {
        expect(emittedUiEvents.length, 2);
        expect(emittedUiEvents[0], isA<LoadingUiEvent>());
        expect(emittedUiEvents[1], isA<ErrorUiEvent>());

        final errorEvent = emittedUiEvents[1] as ErrorUiEvent;
        expect(errorEvent.message, equals('Failed to fetch products'));
      },
    );
  });

  group('uiEventStream', () {
    test('should not be null', () {
      expect(cubit.uiEventStream, isNotNull);
    });

    test('should be a broadcast stream — supports multiple listeners', () {
      final sub1 = cubit.uiEventStream.listen((_) {});
      final sub2 = cubit.uiEventStream.listen((_) {});

      expect(sub1, isNotNull);
      expect(sub2, isNotNull);

      sub1.cancel();
      sub2.cancel();
    });
  });
}
