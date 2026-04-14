import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/config/base_state/base_state.dart';
import 'package:tracking_app/config/exception/unknown_exception.dart';
import 'package:tracking_app/features/taps/orders_tap/orders/domain/entities/orders_metadata_entity.dart';
import 'package:tracking_app/features/taps/orders_tap/orders/domain/entities/orders_response_entity.dart';
import 'package:tracking_app/features/taps/orders_tap/orders/domain/usecases/get_orders_usecase.dart';
import 'package:tracking_app/features/taps/orders_tap/orders/presentation/view_model/orders_cubit.dart';
import 'package:tracking_app/features/taps/orders_tap/orders/presentation/view_model/orders_events.dart';
import 'package:tracking_app/features/taps/orders_tap/orders/presentation/view_model/orders_state.dart';
import 'package:tracking_app/features/taps/orders_tap/orders/presentation/view_model/orders_ui_events.dart';

import 'orders_cubit_test.mocks.dart';

@GenerateMocks([GetOrdersUsecase])
Future<void> main() async {
  late OrdersCubit cubit;
  late MockGetOrdersUsecase mockGetOrdersUsecase;
  late List<OrdersUiEvent> emittedUiEvents;

  const mockOrdersResponseEntity = OrdersResponseEntity(
    message: 'Orders fetched successfully',
    metadata: OrdersMetadataEntity(
      currentPage: 1,
      limit: 10,
      totalItems: 20,
      totalPages: 2,
    ),
    orders: [],
    completedCount: 3,
    cancelledCount: 1,
  );

  setUp(() {
    mockGetOrdersUsecase = MockGetOrdersUsecase();
    cubit = OrdersCubit(mockGetOrdersUsecase);

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
    test('ordersState should have no data', () {
      expect(cubit.state.ordersState.data, isNull);
    });

    test('ordersState should have no errorMessage', () {
      expect(cubit.state.ordersState.errorMessage, isNull);
    });

    test('ordersState should have no isEmpty flag', () {
      expect(cubit.state.ordersState.isEmpty, isNull);
    });
  });

  group('onEvent — GetOrdersEvent — success', () {
    blocTest<OrdersCubit, OrdersState>(
      'emits state with orders data when usecase returns success',
      build: () {
        when(mockGetOrdersUsecase.call()).thenAnswer(
          (_) async => const BaseResponse.success(mockOrdersResponseEntity),
        );
        return cubit;
      },
      act: (cubit) => cubit.onEvent(GetOrdersEvent()),
      verify: (_) {
        verify(mockGetOrdersUsecase.call()).called(1);

        expect(
          cubit.state.ordersState,
          equals(
            const BaseState<OrdersResponseEntity>(
              data: mockOrdersResponseEntity,
            ),
          ),
        );
      },
    );

    blocTest<OrdersCubit, OrdersState>(
      'emits [LoadingUiEvent, SuccessUiEvent] in order on success',
      build: () {
        when(mockGetOrdersUsecase.call()).thenAnswer(
          (_) async => const BaseResponse.success(mockOrdersResponseEntity),
        );
        return cubit;
      },
      act: (cubit) => cubit.onEvent(GetOrdersEvent()),
      verify: (_) {
        expect(emittedUiEvents.length, 2);
        expect(emittedUiEvents[0], isA<LoadingUiEvent>());
        expect(emittedUiEvents[1], isA<SuccessUiEvent>());
      },
    );

    blocTest<OrdersCubit, OrdersState>(
      'SuccessUiEvent carries the correct OrdersResponseEntity',
      build: () {
        when(mockGetOrdersUsecase.call()).thenAnswer(
          (_) async => const BaseResponse.success(mockOrdersResponseEntity),
        );
        return cubit;
      },
      act: (cubit) => cubit.onEvent(GetOrdersEvent()),
      verify: (_) {
        final successEvent = emittedUiEvents.whereType<SuccessUiEvent>().first;
        expect(successEvent.ordersResponseEntity.completedCount, equals(3));
        expect(successEvent.ordersResponseEntity.cancelledCount, equals(1));
        expect(
          successEvent.ordersResponseEntity.message,
          equals('Orders fetched successfully'),
        );
      },
    );

    blocTest<OrdersCubit, OrdersState>(
      'ordersState.data is populated correctly on success',
      build: () {
        when(mockGetOrdersUsecase.call()).thenAnswer(
          (_) async => const BaseResponse.success(mockOrdersResponseEntity),
        );
        return cubit;
      },
      act: (cubit) => cubit.onEvent(GetOrdersEvent()),
      verify: (_) {
        expect(cubit.state.ordersState.data, isNotNull);
        expect(cubit.state.ordersState.data!.completedCount, equals(3));
        expect(cubit.state.ordersState.data!.cancelledCount, equals(1));
      },
    );

    blocTest<OrdersCubit, OrdersState>(
      'ordersState.errorMessage is null on success',
      build: () {
        when(mockGetOrdersUsecase.call()).thenAnswer(
          (_) async => const BaseResponse.success(mockOrdersResponseEntity),
        );
        return cubit;
      },
      act: (cubit) => cubit.onEvent(GetOrdersEvent()),
      verify: (_) {
        expect(cubit.state.ordersState.errorMessage, isNull);
      },
    );
  });

  group('onEvent — GetOrdersEvent — failure', () {
    blocTest<OrdersCubit, OrdersState>(
      'emits state with errorMessage when usecase returns failure',
      build: () {
        when(mockGetOrdersUsecase.call()).thenAnswer(
          (_) async => BaseResponse.failure(
            UnknownException(message: 'Something went wrong'),
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.onEvent(GetOrdersEvent()),
      verify: (_) {
        verify(mockGetOrdersUsecase.call()).called(1);

        expect(cubit.state.ordersState.data, isNull);
        expect(cubit.state.ordersState.errorMessage, isNotEmpty);
      },
    );

    blocTest<OrdersCubit, OrdersState>(
      'emits [LoadingUiEvent, ErrorUiEvent] in order on failure',
      build: () {
        when(mockGetOrdersUsecase.call()).thenAnswer(
          (_) async =>
              BaseResponse.failure(UnknownException(message: 'Network error')),
        );
        return cubit;
      },
      act: (cubit) => cubit.onEvent(GetOrdersEvent()),
      verify: (_) {
        expect(emittedUiEvents.length, 2);
        expect(emittedUiEvents[0], isA<LoadingUiEvent>());
        expect(emittedUiEvents[1], isA<ErrorUiEvent>());
      },
    );

    blocTest<OrdersCubit, OrdersState>(
      'ErrorUiEvent contains the exact error message from the exception',
      build: () {
        when(mockGetOrdersUsecase.call()).thenAnswer(
          (_) async =>
              BaseResponse.failure(UnknownException(message: 'Network error')),
        );
        return cubit;
      },
      act: (cubit) => cubit.onEvent(GetOrdersEvent()),
      verify: (_) {
        final errorEvent = emittedUiEvents.whereType<ErrorUiEvent>().first;
        expect(errorEvent.message, equals('Network error'));
      },
    );

    blocTest<OrdersCubit, OrdersState>(
      'ordersState.errorMessage matches the exception message on failure',
      build: () {
        when(mockGetOrdersUsecase.call()).thenAnswer(
          (_) async => BaseResponse.failure(
            UnknownException(message: 'Server unavailable'),
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.onEvent(GetOrdersEvent()),
      verify: (_) {
        expect(
          cubit.state.ordersState.errorMessage,
          equals('Server unavailable'),
        );
      },
    );

    blocTest<OrdersCubit, OrdersState>(
      'does NOT emit SuccessUiEvent on failure',
      build: () {
        when(mockGetOrdersUsecase.call()).thenAnswer(
          (_) async =>
              BaseResponse.failure(UnknownException(message: 'Timeout')),
        );
        return cubit;
      },
      act: (cubit) => cubit.onEvent(GetOrdersEvent()),
      verify: (_) {
        expect(emittedUiEvents.whereType<SuccessUiEvent>(), isEmpty);
      },
    );
  });

  group('onEvent — multiple consecutive GetOrdersEvent calls', () {
    blocTest<OrdersCubit, OrdersState>(
      'calls the usecase once per GetOrdersEvent',
      build: () {
        when(mockGetOrdersUsecase.call()).thenAnswer(
          (_) async => const BaseResponse.success(mockOrdersResponseEntity),
        );
        return cubit;
      },
      act: (cubit) async {
        cubit.onEvent(GetOrdersEvent());
        cubit.onEvent(GetOrdersEvent());
      },
      verify: (_) {
        verify(mockGetOrdersUsecase.call()).called(2);
      },
    );

    blocTest<OrdersCubit, OrdersState>(
      'retains latest success data after two successful calls',
      build: () {
        when(mockGetOrdersUsecase.call()).thenAnswer(
          (_) async => const BaseResponse.success(mockOrdersResponseEntity),
        );
        return cubit;
      },
      act: (cubit) async {
        cubit.onEvent(GetOrdersEvent());
        await Future<void>.delayed(const Duration(milliseconds: 50));
        cubit.onEvent(GetOrdersEvent());
      },
      verify: (_) {
        expect(cubit.state.ordersState.data, isNotNull);
        expect(cubit.state.ordersState.errorMessage, isNull);
      },
    );

    blocTest<OrdersCubit, OrdersState>(
      'overrides error state with success data when retried after failure',
      build: () {
        var callCount = 0;
        when(mockGetOrdersUsecase.call()).thenAnswer((_) async {
          callCount++;
          if (callCount == 1) {
            return BaseResponse.failure(
              UnknownException(message: 'First call failed'),
            );
          }
          return const BaseResponse.success(mockOrdersResponseEntity);
        });
        return cubit;
      },
      act: (cubit) async {
        cubit.onEvent(GetOrdersEvent());
        await Future<void>.delayed(const Duration(milliseconds: 50));
        cubit.onEvent(GetOrdersEvent());
      },
      verify: (_) {
        expect(cubit.state.ordersState.data, isNotNull);
        expect(cubit.state.ordersState.errorMessage, isNull);
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

    test('emits no events before any onEvent call', () {
      expect(emittedUiEvents, isEmpty);
    });
  });

  group('OrdersState.copyWith', () {
    test('returns a new instance with updated ordersState', () {
      const updated = BaseState<OrdersResponseEntity>(
        data: mockOrdersResponseEntity,
      );
      final newState = cubit.state.copyWith(ordersState: updated);
      expect(newState.ordersState.data, equals(mockOrdersResponseEntity));
    });

    test('preserves existing ordersState when null is passed', () {
      final original = cubit.state;
      final copied = original.copyWith();
      expect(copied.ordersState, equals(original.ordersState));
    });
  });
}
