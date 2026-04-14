class ProductEntity {
  final String id;
  final String title;
  final String? description;
  final String? imageCover;
  final double price;
  final double? priceAfterDiscount;

  ProductEntity({
    required this.id,
    required this.title,
    this.description,
    this.imageCover,
    required this.price,
    this.priceAfterDiscount,
  });
}
