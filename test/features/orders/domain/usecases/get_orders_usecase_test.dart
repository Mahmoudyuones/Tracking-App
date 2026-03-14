import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/config/exception/app_exception.dart';
import 'package:tracking_app/config/exception/server_exception.dart';
import 'package:tracking_app/features/orders/domain/entities/order_entity.dart';
import 'package:tracking_app/features/orders/domain/entities/order_wrapper_entity.dart';
import 'package:tracking_app/features/orders/domain/entities/orders_response_entity.dart';
import 'package:tracking_app/features/orders/domain/repos/orders_repo.dart';
import 'package:tracking_app/features/orders/domain/usecases/get_orders_usecase.dart';

import 'get_orders_usecase_test.mocks.dart';

@GenerateMocks([OrdersRepo])
void main() {
  late GetOrdersUsecase getOrdersUsecase;
  late MockOrdersRepo mockOrdersRepo;

  setUp(() {
    mockOrdersRepo = MockOrdersRepo();
    getOrdersUsecase = GetOrdersUsecase(mockOrdersRepo);
  });

  // Helper to create an OrderWrapperEntity with a given state
  OrderWrapperEntity makeOrderWrapper(String? state) => OrderWrapperEntity(
    id: 'order-id',
    order: OrderEntity(state: state),
  );

  group('call - failure', () {
    test(
      'should return BaseResponse.failure when repo returns failure',
      () async {
        // arrange
        final tException = ServerException(
          message: 'Server error',
          statusCode: 500,
        );
        when(mockOrdersRepo.getOrders()).thenAnswer(
          (_) async => BaseResponse<OrdersResponseEntity>.failure(tException),
        );

        // act
        final result = await getOrdersUsecase();

        // assert
        expect(result, isA<Failure<OrdersResponseEntity>>());
        result.when(
          success: (_) => fail('Expected failure but got success'),
          failure: (exception) {
            expect(exception, isA<AppException>());
            expect(exception, equals(tException));
          },
        );
        verify(mockOrdersRepo.getOrders()).called(1);
        verifyNoMoreInteractions(mockOrdersRepo);
      },
    );

    test('should propagate the exact exception from repo on failure', () async {
      // arrange
      final networkException = ServerException(
        message: 'Not found',
        statusCode: 404,
      );
      when(mockOrdersRepo.getOrders()).thenAnswer(
        (_) async =>
            BaseResponse<OrdersResponseEntity>.failure(networkException),
      );

      // act
      final result = await getOrdersUsecase();

      // assert
      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (exception) {
          expect(exception, equals(networkException));
        },
      );
    });
  });

  group('call - success with empty orders', () {
    test(
      'should return completedCount=0 and cancelledCount=0 when orders list is empty',
      () async {
        // arrange
        final tResponseEntity = OrdersResponseEntity(
          message: 'Success',
          metadata: null,
          orders: [],
        );
        when(
          mockOrdersRepo.getOrders(),
        ).thenAnswer((_) async => BaseResponse.success(tResponseEntity));

        // act
        final result = await getOrdersUsecase();

        // assert
        expect(result, isA<Success<OrdersResponseEntity>>());
        result.when(
          success: (entity) {
            expect(entity.completedCount, 0);
            expect(entity.cancelledCount, 0);
            expect(entity.orders, isEmpty);
          },
          failure: (_) => fail('Expected success but got failure'),
        );
        verify(mockOrdersRepo.getOrders()).called(1);
        verifyNoMoreInteractions(mockOrdersRepo);
      },
    );

    test(
      'should return completedCount=0 and cancelledCount=0 when orders list is null',
      () async {
        // arrange
        final tResponseEntity = OrdersResponseEntity(
          message: 'Success',
          metadata: null,
          orders: null,
        );
        when(
          mockOrdersRepo.getOrders(),
        ).thenAnswer((_) async => BaseResponse.success(tResponseEntity));

        // act
        final result = await getOrdersUsecase();

        // assert
        result.when(
          success: (entity) {
            expect(entity.completedCount, 0);
            expect(entity.cancelledCount, 0);
          },
          failure: (_) => fail('Expected success but got failure'),
        );
      },
    );
  });

  group('call - success with completed orders', () {
    test('should correctly count only completed orders', () async {
      // arrange
      final tResponseEntity = OrdersResponseEntity(
        message: 'Success',
        orders: [
          makeOrderWrapper('completed'),
          makeOrderWrapper('completed'),
          makeOrderWrapper('pending'),
        ],
      );
      when(
        mockOrdersRepo.getOrders(),
      ).thenAnswer((_) async => BaseResponse.success(tResponseEntity));

      // act
      final result = await getOrdersUsecase();

      // assert
      result.when(
        success: (entity) {
          expect(entity.completedCount, 2);
          expect(entity.cancelledCount, 0);
        },
        failure: (_) => fail('Expected success but got failure'),
      );
    });

    test(
      'should match completed state case-insensitively (uppercase state)',
      () async {
        // arrange
        final tResponseEntity = OrdersResponseEntity(
          message: 'Success',
          orders: [
            makeOrderWrapper('COMPLETED'),
            makeOrderWrapper('Completed'),
          ],
        );
        when(
          mockOrdersRepo.getOrders(),
        ).thenAnswer((_) async => BaseResponse.success(tResponseEntity));

        // act
        final result = await getOrdersUsecase();

        // assert
        result.when(
          success: (entity) {
            expect(entity.completedCount, 2);
          },
          failure: (_) => fail('Expected success but got failure'),
        );
      },
    );
  });

  group('call - success with cancelled orders', () {
    test('should correctly count only cancelled orders', () async {
      // arrange
      final tResponseEntity = OrdersResponseEntity(
        message: 'Success',
        orders: [
          makeOrderWrapper('canceled'),
          makeOrderWrapper('canceled'),
          makeOrderWrapper('completed'),
        ],
      );
      when(
        mockOrdersRepo.getOrders(),
      ).thenAnswer((_) async => BaseResponse.success(tResponseEntity));

      // act
      final result = await getOrdersUsecase();

      // assert
      result.when(
        success: (entity) {
          expect(entity.completedCount, 1);
          expect(entity.cancelledCount, 2);
        },
        failure: (_) => fail('Expected success but got failure'),
      );
    });

    test(
      'should match canceled state case-insensitively (uppercase state)',
      () async {
        // arrange
        final tResponseEntity = OrdersResponseEntity(
          message: 'Success',
          orders: [makeOrderWrapper('CANCELED'), makeOrderWrapper('Canceled')],
        );
        when(
          mockOrdersRepo.getOrders(),
        ).thenAnswer((_) async => BaseResponse.success(tResponseEntity));

        // act
        final result = await getOrdersUsecase();

        // assert
        result.when(
          success: (entity) {
            expect(entity.cancelledCount, 2);
          },
          failure: (_) => fail('Expected success but got failure'),
        );
      },
    );
  });

  group('call - success with mixed orders', () {
    test(
      'should correctly count both completed and cancelled orders from mixed list',
      () async {
        // arrange
        final tResponseEntity = OrdersResponseEntity(
          message: 'Success',
          orders: [
            makeOrderWrapper('completed'),
            makeOrderWrapper('canceled'),
            makeOrderWrapper('completed'),
            makeOrderWrapper('pending'),
            makeOrderWrapper('canceled'),
            makeOrderWrapper('in_progress'),
          ],
        );
        when(
          mockOrdersRepo.getOrders(),
        ).thenAnswer((_) async => BaseResponse.success(tResponseEntity));

        // act
        final result = await getOrdersUsecase();

        // assert
        result.when(
          success: (entity) {
            expect(entity.completedCount, 2);
            expect(entity.cancelledCount, 2);
          },
          failure: (_) => fail('Expected success but got failure'),
        );
      },
    );

    test('should preserve message and metadata from repo response', () async {
      // arrange
      final tResponseEntity = OrdersResponseEntity(
        message: 'Orders retrieved successfully',
        metadata: null,
        orders: [makeOrderWrapper('completed')],
      );
      when(
        mockOrdersRepo.getOrders(),
      ).thenAnswer((_) async => BaseResponse.success(tResponseEntity));

      // act
      final result = await getOrdersUsecase();

      // assert
      result.when(
        success: (entity) {
          expect(entity.message, equals('Orders retrieved successfully'));
          expect(entity.metadata, isNull);
          expect(entity.orders, isNotNull);
          expect(entity.orders!.length, 1);
        },
        failure: (_) => fail('Expected success but got failure'),
      );
    });

    test('should ignore orders with null state when counting', () async {
      // arrange
      final tResponseEntity = OrdersResponseEntity(
        message: 'Success',
        orders: [
          makeOrderWrapper(null),
          makeOrderWrapper('completed'),
          makeOrderWrapper(null),
        ],
      );
      when(
        mockOrdersRepo.getOrders(),
      ).thenAnswer((_) async => BaseResponse.success(tResponseEntity));

      // act
      final result = await getOrdersUsecase();

      // assert
      result.when(
        success: (entity) {
          expect(entity.completedCount, 1);
          expect(entity.cancelledCount, 0);
        },
        failure: (_) => fail('Expected success but got failure'),
      );
    });

    test(
      'should call repo.getOrders exactly once per usecase invocation',
      () async {
        // arrange
        final tResponseEntity = OrdersResponseEntity(
          message: 'Success',
          orders: [],
        );
        when(
          mockOrdersRepo.getOrders(),
        ).thenAnswer((_) async => BaseResponse.success(tResponseEntity));

        // act
        await getOrdersUsecase();

        // assert
        verify(mockOrdersRepo.getOrders()).called(1);
        verifyNoMoreInteractions(mockOrdersRepo);
      },
    );
  });
}
