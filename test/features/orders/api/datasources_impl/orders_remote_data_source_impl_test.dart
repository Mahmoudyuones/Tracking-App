import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/config/exception/app_exception.dart';
import 'package:tracking_app/config/exception/server_exception.dart';
import 'package:tracking_app/features/taps/orders_tap/orders/api/api_client/orders_api_client.dart';
import 'package:tracking_app/features/taps/orders_tap/orders/api/datasources_impl/orders_remote_data_source_impl.dart';
import 'package:tracking_app/features/taps/orders_tap/orders/data/models/orders_response_model.dart';

import 'orders_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([OrdersApiClient])
void main() {
  late OrdersRemoteDataSourceImpl ordersRemoteDataSourceImpl;
  late MockOrdersApiClient mockOrdersApiClient;

  setUp(() {
    mockOrdersApiClient = MockOrdersApiClient();
    ordersRemoteDataSourceImpl = OrdersRemoteDataSourceImpl(
      mockOrdersApiClient,
    );
  });

  group('getOrders', () {
    final tOrdersResponseModel = OrdersResponseModel(
      message: 'Success',
      metadata: null,
      orders: [],
    );

    test(
      'should return BaseResponse.success with OrdersResponseModel when API call succeeds',
      () async {
        // arrange
        when(
          mockOrdersApiClient.getOrders(),
        ).thenAnswer((_) async => tOrdersResponseModel);

        // act
        final result = await ordersRemoteDataSourceImpl.getOrders();

        // assert
        expect(result, isA<Success<OrdersResponseModel>>());
        result.when(
          success: (data) {
            expect(data, equals(tOrdersResponseModel));
            expect(data.message, equals('Success'));
            expect(data.orders, isEmpty);
          },
          failure: (_) => fail('Expected success but got failure'),
        );
        verify(mockOrdersApiClient.getOrders()).called(1);
        verifyNoMoreInteractions(mockOrdersApiClient);
      },
    );

    test(
      'should return BaseResponse.failure when API call throws a generic exception',
      () async {
        // arrange
        when(
          mockOrdersApiClient.getOrders(),
        ).thenThrow(Exception('Network error'));

        // act
        final result = await ordersRemoteDataSourceImpl.getOrders();

        // assert
        expect(result, isA<Failure<OrdersResponseModel>>());
        result.when(
          success: (_) => fail('Expected failure but got success'),
          failure: (exception) {
            expect(exception, isA<AppException>());
          },
        );
        verify(mockOrdersApiClient.getOrders()).called(1);
        verifyNoMoreInteractions(mockOrdersApiClient);
      },
    );

    test(
      'should return BaseResponse.failure when API call throws a ServerException',
      () async {
        // arrange
        final serverException = ServerException(
          message: 'Internal server error',
          statusCode: 500,
        );
        when(mockOrdersApiClient.getOrders()).thenThrow(serverException);

        // act
        final result = await ordersRemoteDataSourceImpl.getOrders();

        // assert
        expect(result, isA<Failure<OrdersResponseModel>>());
        result.when(
          success: (_) => fail('Expected failure but got success'),
          failure: (exception) {
            expect(exception, isA<AppException>());
          },
        );
        verify(mockOrdersApiClient.getOrders()).called(1);
        verifyNoMoreInteractions(mockOrdersApiClient);
      },
    );

    test(
      'should return BaseResponse.failure when API call throws a 401 unauthorized exception',
      () async {
        // arrange
        final serverException = ServerException(
          message: 'Unauthorized',
          statusCode: 401,
        );
        when(mockOrdersApiClient.getOrders()).thenThrow(serverException);

        // act
        final result = await ordersRemoteDataSourceImpl.getOrders();

        // assert
        expect(result, isA<Failure<OrdersResponseModel>>());
        result.when(
          success: (_) => fail('Expected failure but got success'),
          failure: (exception) {
            expect(exception, isA<AppException>());
          },
        );
        verify(mockOrdersApiClient.getOrders()).called(1);
        verifyNoMoreInteractions(mockOrdersApiClient);
      },
    );

    test(
      'should call OrdersApiClient.getOrders exactly once per invocation',
      () async {
        // arrange
        when(
          mockOrdersApiClient.getOrders(),
        ).thenAnswer((_) async => tOrdersResponseModel);

        // act
        await ordersRemoteDataSourceImpl.getOrders();

        // assert
        verify(mockOrdersApiClient.getOrders()).called(1);
      },
    );

    test('should propagate orders data correctly on success', () async {
      // arrange
      final tModelWithData = OrdersResponseModel(
        message: 'Orders fetched',
        metadata: null,
        orders: [],
      );
      when(
        mockOrdersApiClient.getOrders(),
      ).thenAnswer((_) async => tModelWithData);

      // act
      final result = await ordersRemoteDataSourceImpl.getOrders();

      // assert
      result.when(
        success: (data) {
          expect(data.message, equals('Orders fetched'));
          expect(data.orders, isNotNull);
        },
        failure: (_) => fail('Expected success but got failure'),
      );
    });
  });
}
