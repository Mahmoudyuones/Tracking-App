import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/config/exception/app_exception.dart';
import 'package:tracking_app/config/exception/server_exception.dart';
import 'package:tracking_app/features/order_details/api/api_client/product_details_api_client.dart';
import 'package:tracking_app/features/order_details/api/datasources_impl/product_details_remote_data_source_impl.dart';
import 'package:tracking_app/features/order_details/data/models/product_details_response_model.dart';
import 'package:tracking_app/features/order_details/data/models/product_order_model.dart';

import 'product_details_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ProductDetailsApiClient])
void main() {
  late ProductDetailsRemoteDataSourceImpl productDetailsRemoteDataSourceImpl;
  late MockProductDetailsApiClient mockProductDetailsApiClient;

  setUp(() {
    mockProductDetailsApiClient = MockProductDetailsApiClient();
    productDetailsRemoteDataSourceImpl = ProductDetailsRemoteDataSourceImpl(
      mockProductDetailsApiClient,
    );
  });

  group('getProductDetails', () {
    const tProductId = '123';
    final tProductDetailsResponseModel = ProductDetailsResponseModel(
      message: 'Success',
      product: ProductOrderModel(id: '1', title: 'Product Title'),
    );

    test(
      'should return BaseResponse.success with ProductDetailsResponseModel when API call is successful',
      () async {
        when(
          mockProductDetailsApiClient.getProductDetails(any),
        ).thenAnswer((_) async => tProductDetailsResponseModel);

        final result = await productDetailsRemoteDataSourceImpl
            .getProductDetails(tProductId);

        expect(result, isA<Success<ProductDetailsResponseModel>>());
        result.when(
          success: (data) {
            expect(data, equals(tProductDetailsResponseModel));
            expect(data.message, equals('Success'));
          },
          failure: (_) => fail('Expected success but got failure'),
        );
        verify(
          mockProductDetailsApiClient.getProductDetails(tProductId),
        ).called(1);
        verifyNoMoreInteractions(mockProductDetailsApiClient);
      },
    );

    test(
      'should return BaseResponse.failure when API call throws an exception',
      () async {
        when(
          mockProductDetailsApiClient.getProductDetails(any),
        ).thenThrow(Exception('Network error'));

        final result = await productDetailsRemoteDataSourceImpl
            .getProductDetails(tProductId);

        expect(result, isA<Failure<ProductDetailsResponseModel>>());
        result.when(
          success: (_) => fail('Expected failure but got success'),
          failure: (exception) {
            expect(exception, isA<AppException>());
          },
        );
        verify(
          mockProductDetailsApiClient.getProductDetails(tProductId),
        ).called(1);
        verifyNoMoreInteractions(mockProductDetailsApiClient);
      },
    );

    test(
      'should return BaseResponse.failure when API call throws a server exception',
      () async {
        final serverException = ServerException(
          message: 'Server error',
          statusCode: 500,
        );
        when(
          mockProductDetailsApiClient.getProductDetails(any),
        ).thenThrow(serverException);

        final result = await productDetailsRemoteDataSourceImpl
            .getProductDetails(tProductId);

        expect(result, isA<Failure<ProductDetailsResponseModel>>());
        result.when(
          success: (_) => fail('Expected failure but got success'),
          failure: (exception) {
            expect(exception, isA<AppException>());
          },
        );
        verify(
          mockProductDetailsApiClient.getProductDetails(tProductId),
        ).called(1);
        verifyNoMoreInteractions(mockProductDetailsApiClient);
      },
    );

    test(
      'should call ProductDetailsApiClient.getProductDetails exactly once',
      () async {
        when(
          mockProductDetailsApiClient.getProductDetails(any),
        ).thenAnswer((_) async => tProductDetailsResponseModel);

        await productDetailsRemoteDataSourceImpl.getProductDetails(tProductId);

        verify(
          mockProductDetailsApiClient.getProductDetails(tProductId),
        ).called(1);
      },
    );
  });
}
