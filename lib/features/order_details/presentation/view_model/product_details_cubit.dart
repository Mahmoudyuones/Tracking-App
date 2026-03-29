import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/base_state/base_state.dart';
import '../../domain/entities/product_details_response_entity.dart';
import '../../domain/usecases/get_product_details_usecase.dart';
import 'product_details_events.dart';
import 'product_details_state.dart';
import 'product_details_ui_events.dart';

@injectable
class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetMultipleProductDetailsUseCase _getMultipleProductDetailsUseCase;

  ProductDetailsCubit(this._getMultipleProductDetailsUseCase)
    : super(
        ProductDetailsState(
          productDetailsState:
              const BaseState<List<ProductDetailsResponseEntity>>(),
        ),
      );

  final _uiEventController =
      StreamController<ProductDetailsUiEvent>.broadcast();
  Stream<ProductDetailsUiEvent> get uiEventStream => _uiEventController.stream;

  void onEvent(ProductDetailsEvent event) {
    switch (event) {
      case GetMultipleProductDetailsEvent():
        _getMultipleProductDetails(event.productIds);
    }
  }

  Future<void> _getMultipleProductDetails(List<String> productIds) async {
    _uiEventController.add(LoadingUiEvent());

    final result = await _getMultipleProductDetailsUseCase.call(productIds);

    if (result.products.isEmpty) {
      _uiEventController.add(
        ErrorUiEvent(message: result.failures.first.message),
      );
      emit(
        state.copyWith(
          productDetailsState: BaseState<List<ProductDetailsResponseEntity>>(
            errorMessage: result.failures.first.message,
          ),
        ),
      );
      return;
    }

    if (result.failures.isNotEmpty) {
      _uiEventController.add(PartialSuccessUiEvent(products: result.products));
    } else {
      _uiEventController.add(
        ProductDetailsSuccessUiEvent(products: result.products),
      );
    }

    emit(
      state.copyWith(
        productDetailsState: BaseState<List<ProductDetailsResponseEntity>>(
          data: result.products,
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    _uiEventController.close();
    return super.close();
  }
}
