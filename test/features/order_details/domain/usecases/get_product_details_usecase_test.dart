import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/config/exception/server_exception.dart';
import 'package:tracking_app/features/order_details/domain/entities/product_details_response_entity.dart';
import 'package:tracking_app/features/order_details/domain/entities/product_order_entity.dart';
import 'package:tracking_app/features/order_details/domain/repos/product_details_repo.dart';
import 'package:tracking_app/features/order_details/domain/usecases/get_product_details_usecase.dart';

import 'get_product_details_usecase_test.mocks.dart';

@GenerateMocks([ProductDetailsRepo])
void main() {
  late GetMultipleProductDetailsUseCase usecase;
  late MockProductDetailsRepo mockProductDetailsRepo;

  setUp(() {
    mockProductDetailsRepo = MockProductDetailsRepo();
    usecase = GetMultipleProductDetailsUseCase(mockProductDetailsRepo);
  });

  group('GetMultipleProductDetailsUseCase', () {
    final tProductIds = ['1', '2'];

    const tProductEntity1 = ProductDetailsResponseEntity(
      product: ProductOrderEntity(
        title: 'Product 1',
        imgCover: 'img1.png',
        price: 100,
      ),
    );

    const tProductEntity2 = ProductDetailsResponseEntity(
      product: ProductOrderEntity(
        title: 'Product 2',
        imgCover: 'img2.png',
        price: 200,
      ),
    );

    final tServerException = ServerException(
      message: 'Server Error',
      statusCode: 500,
    );

    test(
      'should return list of products and empty failures when all repo calls succeed',
      () async {
        when(
          mockProductDetailsRepo.getProductDetails('1'),
        ).thenAnswer((_) async => const BaseResponse.success(tProductEntity1));
        when(
          mockProductDetailsRepo.getProductDetails('2'),
        ).thenAnswer((_) async => const BaseResponse.success(tProductEntity2));

        final result = await usecase(tProductIds);

        expect(result.products, equals([tProductEntity1, tProductEntity2]));
        expect(result.failures, isEmpty);
        verify(mockProductDetailsRepo.getProductDetails('1')).called(1);
        verify(mockProductDetailsRepo.getProductDetails('2')).called(1);
        verifyNoMoreInteractions(mockProductDetailsRepo);
      },
    );

    test(
      'should return list of failures and empty products when all repo calls fail',
      () async {
        when(
          mockProductDetailsRepo.getProductDetails(any),
        ).thenAnswer((_) async => BaseResponse.failure(tServerException));

        final result = await usecase(tProductIds);

        expect(result.products, isEmpty);
        expect(result.failures, equals([tServerException, tServerException]));
        verify(mockProductDetailsRepo.getProductDetails('1')).called(1);
        verify(mockProductDetailsRepo.getProductDetails('2')).called(1);
        verifyNoMoreInteractions(mockProductDetailsRepo);
      },
    );

    test('should return mixed products and failures correctly', () async {
      when(
        mockProductDetailsRepo.getProductDetails('1'),
      ).thenAnswer((_) async => const BaseResponse.success(tProductEntity1));
      when(
        mockProductDetailsRepo.getProductDetails('2'),
      ).thenAnswer((_) async => BaseResponse.failure(tServerException));

      final result = await usecase(tProductIds);

      expect(result.products, equals([tProductEntity1]));
      expect(result.failures, equals([tServerException]));
      verify(mockProductDetailsRepo.getProductDetails('1')).called(1);
      verify(mockProductDetailsRepo.getProductDetails('2')).called(1);
      verifyNoMoreInteractions(mockProductDetailsRepo);
    });
  });
}
