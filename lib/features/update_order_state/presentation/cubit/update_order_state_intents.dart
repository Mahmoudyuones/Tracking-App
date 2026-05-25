sealed class UpdateOrderStateIntents {
  const UpdateOrderStateIntents();
}

class GetOrderByOrderIdIntent extends UpdateOrderStateIntents {
  final String userId;
  final String orderId;

  const GetOrderByOrderIdIntent({required this.userId, required this.orderId});
}

class ChangeOrderStatusIntent extends UpdateOrderStateIntents {
  final String orderId;
  final String state;
  final String userId;

  const ChangeOrderStatusIntent({
    required this.orderId,
    required this.state,
    required this.userId,
  });
}
