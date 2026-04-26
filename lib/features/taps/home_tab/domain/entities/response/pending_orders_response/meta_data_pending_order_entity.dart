class MetaDataPendingOrderEntity {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int limit;

  MetaDataPendingOrderEntity({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.limit,
  });
}
