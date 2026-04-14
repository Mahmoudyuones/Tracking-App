sealed class HomeIntents {
  const HomeIntents();
}

class GetPendingOrdersIntent extends HomeIntents {
  final int limit;
  const GetPendingOrdersIntent({this.limit = 10});
}
