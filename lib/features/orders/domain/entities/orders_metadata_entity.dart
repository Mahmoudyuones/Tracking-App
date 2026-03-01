class OrdersMetadataEntity {
  final int? currentPage;
  final int? totalPages;
  final int? totalItems;
  final int? limit;

  const OrdersMetadataEntity({
    this.currentPage,
    this.totalPages,
    this.totalItems,
    this.limit,
  });
}
