sealed class ProductDetailsEvent {}

class GetMultipleProductDetailsEvent extends ProductDetailsEvent {
  final List<String> productIds;
  GetMultipleProductDetailsEvent({required this.productIds});
}
