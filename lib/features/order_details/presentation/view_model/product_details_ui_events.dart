import '../../domain/entities/product_details_response_entity.dart';

sealed class ProductDetailsUiEvent {}

class LoadingUiEvent extends ProductDetailsUiEvent {}

class ErrorUiEvent extends ProductDetailsUiEvent {
  final String message;
  ErrorUiEvent({required this.message});
}

class ProductDetailsSuccessUiEvent extends ProductDetailsUiEvent {
  final List<ProductDetailsResponseEntity> products;
  ProductDetailsSuccessUiEvent({required this.products});
}

class PartialSuccessUiEvent extends ProductDetailsUiEvent {
  final List<ProductDetailsResponseEntity> products;
  PartialSuccessUiEvent({required this.products});
}
