import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/config/exception/app_exception.dart';
import 'package:tracking_app/config/exception/server_exception.dart';
import 'package:tracking_app/features/taps/orders_tap/orders/api/datasources_impl/orders_remote_data_source_impl.dart';
import 'package:tracking_app/features/taps/orders_tap/orders/data/models/orders_response_model.dart';
import 'package:tracking_app/features/taps/orders_tap/orders/data/repos/orders_repo_impl.dart';
import 'package:tracking_app/features/taps/orders_tap/orders/domain/entities/orders_response_entity.dart';

import 'orders_repo_impl_test.mocks.dart';

@GenerateMocks([OrdersRemoteDataSourceImpl])
void main() {
  late OrdersRepoImpl ordersRepoImpl;
  late MockOrdersRemoteDataSourceImpl mockOrdersRemoteDataSourceImpl;

  setUp(() {
    mockOrdersRemoteDataSourceImpl = MockOrdersRemoteDataSourceImpl();
    ordersRepoImpl = OrdersRepoImpl(mockOrdersRemoteDataSourceImpl);
  });

  group('getOrders', () {
    final tOrdersResponseModel = OrdersResponseModel(
      message: 'Success',
      metadata: null,
      orders: [],
    );

    final tAppException = ServerException(
      message: 'Server error',
      statusCode: 500,
    );

    test(
      'should return BaseResponse.success with OrdersResponseEntity when data source returns success',
      () async {
        // arrange
        when(
          mockOrdersRemoteDataSourceImpl.getOrders(),
        ).thenAnswer((_) async => BaseResponse.success(tOrdersResponseModel));

        // act
        final result = await ordersRepoImpl.getOrders();

        // assert
        expect(result, isA<Success<OrdersResponseEntity>>());
        result.when(
          success: (entity) {
            expect(entity, isA<OrdersResponseEntity>());
            expect(entity.message, equals('Success'));
            expect(entity.orders, isEmpty);
          },
          failure: (_) => fail('Expected success but got failure'),
        );
        verify(mockOrdersRemoteDataSourceImpl.getOrders()).called(1);
        verifyNoMoreInteractions(mockOrdersRemoteDataSourceImpl);
      },
    );

    test(
      'should return BaseResponse.failure when data source returns failure',
      () async {
        // arrange
        when(mockOrdersRemoteDataSourceImpl.getOrders()).thenAnswer(
          (_) async => BaseResponse<OrdersResponseModel>.failure(tAppException),
        );

        // act
        final result = await ordersRepoImpl.getOrders();

        // assert
        expect(result, isA<Failure<OrdersResponseEntity>>());
        result.when(
          success: (_) => fail('Expected failure but got success'),
          failure: (exception) {
            expect(exception, isA<AppException>());
            expect(exception, equals(tAppException));
          },
        );
        verify(mockOrdersRemoteDataSourceImpl.getOrders()).called(1);
        verifyNoMoreInteractions(mockOrdersRemoteDataSourceImpl);
      },
    );

    test('should call remote data source getOrders exactly once', () async {
      // arrange
      when(
        mockOrdersRemoteDataSourceImpl.getOrders(),
      ).thenAnswer((_) async => BaseResponse.success(tOrdersResponseModel));

      // act
      await ordersRepoImpl.getOrders();

      // assert
      verify(mockOrdersRemoteDataSourceImpl.getOrders()).called(1);
    });

    test(
      'should correctly map OrdersResponseModel to OrdersResponseEntity',
      () async {
        // arrange
        final tModelWithMessage = OrdersResponseModel(
          message: 'Orders loaded',
          metadata: null,
          orders: [],
        );
        when(
          mockOrdersRemoteDataSourceImpl.getOrders(),
        ).thenAnswer((_) async => BaseResponse.success(tModelWithMessage));

        // act
        final result = await ordersRepoImpl.getOrders();

        // assert
        result.when(
          success: (entity) {
            expect(entity.message, equals(tModelWithMessage.message));
            expect(entity.metadata, isNull);
            expect(entity.orders, isEmpty);
          },
          failure: (_) => fail('Expected success but got failure'),
        );
      },
    );

    test(
      'should propagate the same exception from data source on failure',
      () async {
        // arrange
        final networkException = ServerException(
          message: 'Not found',
          statusCode: 404,
        );
        when(mockOrdersRemoteDataSourceImpl.getOrders()).thenAnswer(
          (_) async =>
              BaseResponse<OrdersResponseModel>.failure(networkException),
        );

        // act
        final result = await ordersRepoImpl.getOrders();

        // assert
        result.when(
          success: (_) => fail('Expected failure but got success'),
          failure: (exception) {
            expect(exception, equals(networkException));
          },
        );
        verify(mockOrdersRemoteDataSourceImpl.getOrders()).called(1);
        verifyNoMoreInteractions(mockOrdersRemoteDataSourceImpl);
      },
    );
  });
}
