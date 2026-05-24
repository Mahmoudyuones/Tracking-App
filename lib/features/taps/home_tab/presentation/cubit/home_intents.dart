import '../../domain/entities/response/pending_orders_response/order_entity.dart';

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
  final OrderEntity orderDetails;
  const StartOrderIntent({required this.orderId, required this.orderDetails});
}

class GetMyProfileIntent extends HomeIntents {}
