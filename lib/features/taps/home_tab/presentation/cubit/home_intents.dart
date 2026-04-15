sealed class HomeIntents {
  const HomeIntents();
}

class GetPendingOrdersIntent extends HomeIntents {
  final int? limit;
  const GetPendingOrdersIntent({this.limit});
}

class LoadMorePendingOrdersIntent extends HomeIntents {}

class RejectOrderIntent extends HomeIntents {
  final String orderId;
  const RejectOrderIntent({required this.orderId});
}

class StartOrderIntent extends HomeIntents {
  final String orderId;
  const StartOrderIntent({required this.orderId});
}
