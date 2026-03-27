import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/config/exception/app_exception.dart';
import 'package:tracking_app/config/exception/server_exception.dart';
import 'package:tracking_app/features/order_details/data/datasources/product_details_remote_data_source.dart';
import 'package:tracking_app/features/order_details/data/models/product_details_response_model.dart';
import 'package:tracking_app/features/order_details/data/models/product_order_model.dart';
import 'package:tracking_app/features/order_details/data/repos/product_details_repo_impl.dart';
import 'package:tracking_app/features/order_details/domain/entities/product_details_response_entity.dart';

import 'product_details_repo_impl_test.mocks.dart';

@GenerateMocks([ProductDetailsRemoteDataSource])
void main() {
  late ProductDetailsRepoImpl productDetailsRepoImpl;
  late MockProductDetailsRemoteDataSource mockProductDetailsRemoteDataSource;

  setUp(() {
    mockProductDetailsRemoteDataSource = MockProductDetailsRemoteDataSource();
    productDetailsRepoImpl = ProductDetailsRepoImpl(
      mockProductDetailsRemoteDataSource,
    );
  });

  group('getProductDetails', () {
    const tProductId = '123';

    final tProductOrderModel = ProductOrderModel(
      id: '1',
      title: 'Product Title',
      imgCover: 'https://example.com/image.png',
      price: 100,
    );

    final tProductDetailsResponseModel = ProductDetailsResponseModel(
      message: 'Success',
      product: tProductOrderModel,
    );

    final tAppException = ServerException(
      message: 'Server error',
      statusCode: 500,
    );

    test(
      'should return BaseResponse.success with ProductDetailsResponseEntity when remote data source returns success',
      () async {
        when(
          mockProductDetailsRemoteDataSource.getProductDetails(any),
        ).thenAnswer(
          (_) async => BaseResponse.success(tProductDetailsResponseModel),
        );

        final result = await productDetailsRepoImpl.getProductDetails(
          tProductId,
        );

        expect(result, isA<Success<ProductDetailsResponseEntity>>());
        result.when(
          success: (entity) {
            expect(entity, isA<ProductDetailsResponseEntity>());
            expect(entity.product?.title, equals('Product Title'));
            expect(
              entity.product?.imgCover,
              equals('https://example.com/image.png'),
            );
            expect(entity.product?.price, equals(100));
          },
          failure: (_) => fail('Expected success but got failure'),
        );
        verify(
          mockProductDetailsRemoteDataSource.getProductDetails(tProductId),
        ).called(1);
        verifyNoMoreInteractions(mockProductDetailsRemoteDataSource);
      },
    );

    test(
      'should return BaseResponse.failure when remote data source returns failure',
      () async {
        when(
          mockProductDetailsRemoteDataSource.getProductDetails(any),
        ).thenAnswer(
          (_) async =>
              BaseResponse<ProductDetailsResponseModel>.failure(tAppException),
        );

        final result = await productDetailsRepoImpl.getProductDetails(
          tProductId,
        );

        expect(result, isA<Failure<ProductDetailsResponseEntity>>());
        result.when(
          success: (_) => fail('Expected failure but got success'),
          failure: (exception) {
            expect(exception, isA<AppException>());
            expect(exception, equals(tAppException));
          },
        );
        verify(
          mockProductDetailsRemoteDataSource.getProductDetails(tProductId),
        ).called(1);
        verifyNoMoreInteractions(mockProductDetailsRemoteDataSource);
      },
    );

    test(
      'should call remote data source getProductDetails exactly once',
      () async {
        when(
          mockProductDetailsRemoteDataSource.getProductDetails(any),
        ).thenAnswer(
          (_) async => BaseResponse.success(tProductDetailsResponseModel),
        );

        await productDetailsRepoImpl.getProductDetails(tProductId);

        verify(
          mockProductDetailsRemoteDataSource.getProductDetails(tProductId),
        ).called(1);
      },
    );

    test(
      'should transform ProductDetailsResponseModel to ProductDetailsResponseEntity correctly',
      () async {
        when(
          mockProductDetailsRemoteDataSource.getProductDetails(any),
        ).thenAnswer(
          (_) async => BaseResponse.success(tProductDetailsResponseModel),
        );

        final result = await productDetailsRepoImpl.getProductDetails(
          tProductId,
        );

        result.when(
          success: (entity) {
            expect(entity.product?.title, equals(tProductOrderModel.title));
            expect(
              entity.product?.imgCover,
              equals(tProductOrderModel.imgCover),
            );
            expect(entity.product?.price, equals(tProductOrderModel.price));
          },
          failure: (_) => fail('Expected success but got failure'),
        );
      },
    );
  });
}
